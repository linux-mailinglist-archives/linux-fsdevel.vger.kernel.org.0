Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DF580F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 11:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiGZJLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGZJLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:11:03 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Jul 2022 02:11:01 PDT
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74011A32
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 02:11:00 -0700 (PDT)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-03.nifty.com with ESMTP id 26Q947QV024278
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 18:04:07 +0900
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26Q93a2x009320;
        Tue, 26 Jul 2022 18:03:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26Q93a2x009320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658826217;
        bh=4AoSB3h+V1S0Zi2hR9Ffz+aEk8obXbEQALYdUythM8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DNMsI719EsEHWEJB1i0fmsw8dcnEb9Xgi3ZvZPQ7nL4LCs6mEM+irmydqM1XbJO5O
         sbYBElMFxA8CQw7rhpwHk8+OI+ICwolToeVjuEgIu6cJh7eTfhWC3FvBlXLOwlJVPd
         Zi9GWYGLvlQOiIkT7dNS33ZSHKwce1XHFGRIHRjHMQBbFX2c1/mqgcsaUR/MxS2FI3
         jeFJFXbn7MeusLl0FX2/3etDNMmWOuvRuqoCVSTiemp7U7ijrbGddFdZHoHbCjkTxQ
         vZnmJY8/CXUkzUZpOmikIuMV+7nFitjts8WJARI/8gbTmSOYb69ELH5nB5U7Ef5juY
         aL9PwlE/bqk8Q==
X-Nifty-SrcIP: [209.85.128.52]
Received: by mail-wm1-f52.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso7762192wms.2;
        Tue, 26 Jul 2022 02:03:36 -0700 (PDT)
X-Gm-Message-State: AJIora/8OBjH+AEY/YSBFSYt3fNwSZak5ASZyTo1khym69B92+ShYc6I
        34b5iRDWlkeabqSPgrwUg0E/d+kAumjtdt2Z9ao=
X-Google-Smtp-Source: AGRyM1t5i57cSEMRwg05NPugl/q2APQQrpbyEWMfhb46+2n3Uw000nam92VwO6YtRq/0tgh+LKH+Ih9YNZsIEOnld7A=
X-Received: by 2002:a05:600c:1da8:b0:3a3:1969:b0d with SMTP id
 p40-20020a05600c1da800b003a319690b0dmr23582274wms.172.1658826215094; Tue, 26
 Jul 2022 02:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220722022416.137548-1-mfo@canonical.com>
In-Reply-To: <20220722022416.137548-1-mfo@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Jul 2022 18:02:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=7zgOiqTD9okXfZXroFH1yagMFsRuq0G-z6OfSUPLQg@mail.gmail.com>
Message-ID: <CAK7LNAR=7zgOiqTD9okXfZXroFH1yagMFsRuq0G-z6OfSUPLQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Introduce "sysctl:" module aliases
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:24 AM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
> This series allows modules to have "sysctl:<procname>" module aliases
> for sysctl entries, registering sysctl tables with modpost/file2alias.
> (Similarly to "pci:<IDs>" aliases for PCI ID tables in device drivers.)
>
> The issue behind it: if a sysctl value is in /etc/sysctl.{conf,d/*.conf}
> but does not exist in /proc/sys/ when the userspace tool that applies it
> runs, it does not get set.
>
> It would be nice if the tool could run 'modprobe sysctl:<something>' and
> get that '/proc/sys/.../something' up (as an administrator configured it)
> and then set it, as intended. (A bit like PCI ID-based module loading.)
>
> ...
>
> The series is relatively simple, except for patch 4 (IMHO) due to ELF.
>
> - Patches 1-2 simplify ELF code in modpost.c (code moves, not in-depth).
> - Patches 3-4 implement the feature (patch 4 is more in-depth).
> - Patches 5-6 consume and expose it.
>
> I have tested it on x86_64 with next-20220721, and it looks correct
> ('modprobe sysctl:nf_conntrack_max' works; other aliases there; see below=
).


I did not test this patch set at all, but I am afraid
you took a good case as an example.



I see two locations for the "fib_multipath_hash_fields" parameter
for example.

#  find /proc/sys/ -name fib_multipath_hash_fields
/proc/sys/net/ipv4/fib_multipath_hash_fields
/proc/sys/net/ipv6/fib_multipath_hash_fields


If I run

   modprobe sysctl:fib_multipath_hash_fields

Which one will be loaded, net/ipv4/sysctl_net_ipv4.c
or ipv6/sysctl_net_ipv6.c ?

Of course, IPv4 is always built-in, so ipv6.ko will be loaded in this case.
But, let's think. The basename is not enough to identify
which code resulted in that sysctl property.
The PCI vendor/device ID is meant to be unique. That's the difference.


You may argue the full path is globally unique, so

  modprobe  sysctl:net/ipv6/fib_multipath_hash_fields

should work, but that may not be so feasible to implement
because not all file paths are static.


On my machine:

# find  /proc/sys  -name  forwarding
/proc/sys/net/ipv4/conf/all/forwarding
/proc/sys/net/ipv4/conf/br-22440b7735e7/forwarding
/proc/sys/net/ipv4/conf/br-3e8284a56053/forwarding
/proc/sys/net/ipv4/conf/br-9b27f0f9e130/forwarding
/proc/sys/net/ipv4/conf/br-bc5fbfa838fc/forwarding
/proc/sys/net/ipv4/conf/br-ca51e25e8af8/forwarding
/proc/sys/net/ipv4/conf/default/forwarding
/proc/sys/net/ipv4/conf/docker0/forwarding
/proc/sys/net/ipv4/conf/lo/forwarding
/proc/sys/net/ipv4/conf/lxcbr0/forwarding
/proc/sys/net/ipv4/conf/veth6e3e4b8/forwarding
/proc/sys/net/ipv4/conf/virbr0/forwarding
/proc/sys/net/ipv4/conf/vpn0/forwarding
/proc/sys/net/ipv4/conf/wlp0s20f3/forwarding
/proc/sys/net/ipv6/conf/all/forwarding
/proc/sys/net/ipv6/conf/br-22440b7735e7/forwarding
/proc/sys/net/ipv6/conf/br-3e8284a56053/forwarding
/proc/sys/net/ipv6/conf/br-9b27f0f9e130/forwarding
/proc/sys/net/ipv6/conf/br-bc5fbfa838fc/forwarding
/proc/sys/net/ipv6/conf/br-ca51e25e8af8/forwarding
/proc/sys/net/ipv6/conf/default/forwarding
/proc/sys/net/ipv6/conf/docker0/forwarding
/proc/sys/net/ipv6/conf/lo/forwarding
/proc/sys/net/ipv6/conf/lxcbr0/forwarding
/proc/sys/net/ipv6/conf/veth6e3e4b8/forwarding
/proc/sys/net/ipv6/conf/virbr0/forwarding
/proc/sys/net/ipv6/conf/vpn0/forwarding
/proc/sys/net/ipv6/conf/wlp0s20f3/forwarding


I do not know how to do it correctly.




>
> I plan to test other archs by cross-building 'allmodconfig' and checking
> the .mod.c files and modpost output (eg, warnings) for no changes at all,
> and nf_conntrack.mod.c for expected sysctl aliases. [based on feedback.]
> (i.e., changes didn't break modpost, and ELF code works on other archs.)
>
> Happy to receive suggestions to improve test coverage and functionality.
>
> I didn't look much at auto-registration with modpost using the register
> functions for sysctl, but it seems it would need plumbing, if possible.
>
> Let's see review/feedback on the basics first.
>
> thanks,
> Mauricio
>
> ...
>
> Some context.
>
> Even though that issue might be expected and obvious, its consequences
> sometimes are not.
>
> An example is the nf_conntrack_max value, that in busy gateways/routers
> /cloud deployments can affect performance and functionality more subtly,
> or even fill the kernel log non-stop with 'table full, dropping packet',
> if a value greater than the default value is not used.
>
> The current solution (workaround, arguably) for this is to include such
> modules in /etc/modules (or in /etc/modules-load.d/*.conf with systemd),
> which loads them before an userspace tool (procps's sysctl or systemd's
> systemd-sysctl{,.service}) runs, so /proc/sys/... exists when it runs.
>
> ...
>
> That is simple, indeed, but comes w/ technical debt. (ugly stuff warning!=
)
>
> Now there are many _different_ pieces of code that use the _same_ module
> doing that (eg, deployment tools/scripts for openstack nova and neutron,
> firewalls, and maybe more).
>
> And sometimes when components are split or deployed to different nodes
> it turns out that in the next reboot we figure (through an issue) that
> some component did set /etc/sysctl.conf but not /etc/modules.conf, or
> relied in the ex-colocated component doing that.
>
> This has generated several one-off fixes at this point in some projects.
> (I have submitted one of those, actually, a while ago.)
>
> Also, some of those fixes (or original code) put 'nf_conntrack_ipv{4,6}'
> in /etc/modules, getting 'nf_conntrack' loaded via module dependencies
> (maybe it was the right module for them at the time, for some reason).
>
> So, that component (or a colocated component) got nf_conntrack.ko too.
>
> *BUT* after an upgrade from Ubuntu 18.04 (4.15-based kernel) to 20.04
> (5.4-based kernel), the nf_conntrack_ipv{4,6}.ko modules do not exist
> anymore, and now nf_conntrack.ko is no longer loaded, and the sysctl
> nf_conntrack_max is no longer applied. (Someone had to figure it out.)
>
> And now maybe we'd need release/kernel-version checks in scripts that
> use the workaround of /etc/modules for /etc/sysctl.conf configuration.
>
> (Yes, it was ugly stuff.)
>
> ...
>
> Well, this last point seemed like "ok, that's enough; we can do better."
>
> I'm not sure this approach is "better" in all reasons, but hopefully it
> might help starting something that is. =F0=9F=99=8F
>
> cheers,
> Mauricio
>
> ...
>
> Tests:
>
>     $ cat /proc/sys/kernel/modprobe_sysctl_alias
>     1
>
>     $ cat /proc/sys/net/netfilter/nf_conntrack_max
>     cat: /proc/sys/net/netfilter/nf_conntrack_max: No such file or direct=
ory
>
>     $ lsmod | grep nf_conntrack
>     $
>
>     $ sudo modprobe sysctl:nf_conntrack_max
>
>     $ cat /proc/sys/net/netfilter/nf_conntrack_max
>     262144
>
>     $ lsmod | grep nf_conntrack
>     nf_conntrack          110592  0
>     nf_defrag_ipv6         20480  1 nf_conntrack
>     nf_defrag_ipv4         16384  1 nf_conntrack
>
>     $ modinfo nf_conntrack | grep ^alias:
>     alias:          nf_conntrack-10
>     alias:          nf_conntrack-2
>     alias:          ip_conntrack
>     alias:          sysctl:nf_conntrack_icmpv6_timeout
>     alias:          sysctl:nf_conntrack_icmp_timeout
>     alias:          sysctl:nf_conntrack_udp_timeout_stream
>     alias:          sysctl:nf_conntrack_udp_timeout
>     alias:          sysctl:nf_conntrack_tcp_max_retrans
>     alias:          sysctl:nf_conntrack_tcp_ignore_invalid_rst
>     alias:          sysctl:nf_conntrack_tcp_be_liberal
>     alias:          sysctl:nf_conntrack_tcp_loose
>     alias:          sysctl:nf_conntrack_tcp_timeout_unacknowledged
>     alias:          sysctl:nf_conntrack_tcp_timeout_max_retrans
>     alias:          sysctl:nf_conntrack_tcp_timeout_close
>     alias:          sysctl:nf_conntrack_tcp_timeout_time_wait
>     alias:          sysctl:nf_conntrack_tcp_timeout_last_ack
>     alias:          sysctl:nf_conntrack_tcp_timeout_close_wait
>     alias:          sysctl:nf_conntrack_tcp_timeout_fin_wait
>     alias:          sysctl:nf_conntrack_tcp_timeout_established
>     alias:          sysctl:nf_conntrack_tcp_timeout_syn_recv
>     alias:          sysctl:nf_conntrack_tcp_timeout_syn_sent
>     alias:          sysctl:nf_conntrack_generic_timeout
>     alias:          sysctl:nf_conntrack_helper
>     alias:          sysctl:nf_conntrack_acct
>     alias:          sysctl:nf_conntrack_expect_max
>     alias:          sysctl:nf_conntrack_log_invalid
>     alias:          sysctl:nf_conntrack_checksum
>     alias:          sysctl:nf_conntrack_buckets
>     alias:          sysctl:nf_conntrack_count
>     alias:          sysctl:nf_conntrack_max
>
>     $ modinfo r8169 | grep ^alias:
>     alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
>     alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
>     alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
>     alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
>     alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
>     alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
>     alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
>     alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
>     alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
>     alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
>     alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*
>
> Mauricio Faria de Oliveira (6):
>   modpost: factor out elf/arch-specific code from section_rel[a]()
>   modpost: deduplicate section_rel[a]()
>   sysctl, mod_devicetable: shadow struct ctl_table.procname for
>     file2alias
>   module, modpost: introduce support for MODULE_SYSCTL_TABLE
>   netfilter: conntrack: use MODULE_SYSCTL_TABLE
>   sysctl: introduce /proc/sys/kernel/modprobe_sysctl_alias
>
>  fs/proc/proc_sysctl.c                   |  27 ++++
>  include/linux/mod_devicetable.h         |  25 ++++
>  include/linux/module.h                  |   8 ++
>  include/linux/sysctl.h                  |  11 +-
>  kernel/sysctl.c                         |  10 ++
>  net/netfilter/nf_conntrack_standalone.c |   4 +
>  scripts/mod/devicetable-offsets.c       |   3 +
>  scripts/mod/file2alias.c                | 111 +++++++++++++++
>  scripts/mod/modpost.c                   | 178 +++++++++++++-----------
>  scripts/mod/modpost.h                   |   3 +
>  10 files changed, 296 insertions(+), 84 deletions(-)
>
> --
> 2.25.1
>


--
Best Regards
Masahiro Yamada
