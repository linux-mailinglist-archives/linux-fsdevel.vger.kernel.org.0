Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8635257D883
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 04:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGVCY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 22:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiGVCY2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:24:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8197A18
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:25 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3171D3F12D
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 02:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658456663;
        bh=gE2fBCxSAZxAZ1e5pYBDGgK4+lgINM9j58AumI+dplg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=YbKCXytefaaqCKNx2yTnpabC2q1+DCbtNlAI3jJL0rLGfN66MhCzrQmn7qBqGKGTP
         MbxldIoTD99N4T/Xm30NaBA3nhPugNpMqkJLMW/fIBuLp/c2n+0Bjb4LYU6/21Cbvf
         GIhEkROOX58pqr6REfRk0z4BYv4Ofg3vUDxaldALXaIRu5DgWEJO9WqMI7ogi41bNq
         8raj9pO0AOBKZ7YGLbVnuuIv6HJYjgWtaPssf17PBysX7ti0wAsjES6s2zqKYFoPSo
         JxXydNfiNxbTZBPTnaDz3pisKejPKqqzyNlMKq/8t+wTJNYr39xvr5kORrNeJkiXQn
         6ThLWJ3vGqYOA==
Received: by mail-oi1-f200.google.com with SMTP id b205-20020aca34d6000000b0033a33a68361so1705470oia.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 19:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gE2fBCxSAZxAZ1e5pYBDGgK4+lgINM9j58AumI+dplg=;
        b=vuZTyC9UWBzsNaBLxO4+ekVVxiQ4kivlW6VJGSu3bjBLRBeE0nJ945eaO86BU0abLx
         +ZOD8Ote7MARGs3vkWep5MEs3OxquN9kSeVT6550R0QCLbNFxiaVeeGd1Zj84Nh5VXtc
         B3/YP97qY6DgDTpB2nFdT1DMy09RekpkfxQIp7koFBMWbgr1BDlNsifdG/r0/ktrdqVe
         FPosUTAXgQ9EAkQs1CiCPZ47LOSK8TcIGAa7cr1PoWlXl5mSdjJDaPSIBeW9LGZwFEd0
         yjwt/3iRgUcacgIsilODkw132VResZbdnd4byCLzRUT3BL88Y0RnAK8ivOBkFRGm0snN
         bUSQ==
X-Gm-Message-State: AJIora+37nNldf+L9/R+Zf1mLno+/+J/K3qpSzVEn1mXpRYy0+GM4ViO
        E6kCmHVVnDJv98FzMs1/WWBynWmp+hQ7WYJtKYUTIovlIaaU5Gk9qdj7uOSZ7dF/8D6BNY5vIZ2
        oxQYVrzCtk1yGOVi2FTrjD1Q+8bHbxXgdwgZmJSGA/8A=
X-Received: by 2002:aca:5808:0:b0:33a:6ce9:6cef with SMTP id m8-20020aca5808000000b0033a6ce96cefmr485648oib.37.1658456661917;
        Thu, 21 Jul 2022 19:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vUAvmwMyR83RiCEZqwtI9Za2Pb9qs6xEjYboEZH5/ptc+/s/m6H+qePEdaPU6dNi8LehfMlA==
X-Received: by 2002:aca:5808:0:b0:33a:6ce9:6cef with SMTP id m8-20020aca5808000000b0033a6ce96cefmr485634oib.37.1658456661608;
        Thu, 21 Jul 2022 19:24:21 -0700 (PDT)
Received: from mfo-t470.. ([2804:14c:4e1:8732:c479:1206:16fb:ce1f])
        by smtp.gmail.com with ESMTPSA id k23-20020a056870959700b000f5f4ad194bsm1814528oao.25.2022.07.21.19.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 19:24:21 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: [RFC PATCH 0/6] Introduce "sysctl:" module aliases
Date:   Thu, 21 Jul 2022 23:24:10 -0300
Message-Id: <20220722022416.137548-1-mfo@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series allows modules to have "sysctl:<procname>" module aliases
for sysctl entries, registering sysctl tables with modpost/file2alias.
(Similarly to "pci:<IDs>" aliases for PCI ID tables in device drivers.)

The issue behind it: if a sysctl value is in /etc/sysctl.{conf,d/*.conf}
but does not exist in /proc/sys/ when the userspace tool that applies it
runs, it does not get set.

It would be nice if the tool could run 'modprobe sysctl:<something>' and
get that '/proc/sys/.../something' up (as an administrator configured it)
and then set it, as intended. (A bit like PCI ID-based module loading.)

...

The series is relatively simple, except for patch 4 (IMHO) due to ELF.

- Patches 1-2 simplify ELF code in modpost.c (code moves, not in-depth).
- Patches 3-4 implement the feature (patch 4 is more in-depth).
- Patches 5-6 consume and expose it.

I have tested it on x86_64 with next-20220721, and it looks correct
('modprobe sysctl:nf_conntrack_max' works; other aliases there; see below).

I plan to test other archs by cross-building 'allmodconfig' and checking
the .mod.c files and modpost output (eg, warnings) for no changes at all,
and nf_conntrack.mod.c for expected sysctl aliases. [based on feedback.]
(i.e., changes didn't break modpost, and ELF code works on other archs.)

Happy to receive suggestions to improve test coverage and functionality.

I didn't look much at auto-registration with modpost using the register
functions for sysctl, but it seems it would need plumbing, if possible.

Let's see review/feedback on the basics first.

thanks,
Mauricio

...

Some context.

Even though that issue might be expected and obvious, its consequences
sometimes are not.

An example is the nf_conntrack_max value, that in busy gateways/routers
/cloud deployments can affect performance and functionality more subtly,
or even fill the kernel log non-stop with 'table full, dropping packet',
if a value greater than the default value is not used.

The current solution (workaround, arguably) for this is to include such
modules in /etc/modules (or in /etc/modules-load.d/*.conf with systemd),
which loads them before an userspace tool (procps's sysctl or systemd's
systemd-sysctl{,.service}) runs, so /proc/sys/... exists when it runs.

...

That is simple, indeed, but comes w/ technical debt. (ugly stuff warning!)

Now there are many _different_ pieces of code that use the _same_ module
doing that (eg, deployment tools/scripts for openstack nova and neutron,
firewalls, and maybe more).

And sometimes when components are split or deployed to different nodes
it turns out that in the next reboot we figure (through an issue) that
some component did set /etc/sysctl.conf but not /etc/modules.conf, or
relied in the ex-colocated component doing that.

This has generated several one-off fixes at this point in some projects.
(I have submitted one of those, actually, a while ago.)

Also, some of those fixes (or original code) put 'nf_conntrack_ipv{4,6}'
in /etc/modules, getting 'nf_conntrack' loaded via module dependencies
(maybe it was the right module for them at the time, for some reason).

So, that component (or a colocated component) got nf_conntrack.ko too.

*BUT* after an upgrade from Ubuntu 18.04 (4.15-based kernel) to 20.04
(5.4-based kernel), the nf_conntrack_ipv{4,6}.ko modules do not exist
anymore, and now nf_conntrack.ko is no longer loaded, and the sysctl
nf_conntrack_max is no longer applied. (Someone had to figure it out.)

And now maybe we'd need release/kernel-version checks in scripts that
use the workaround of /etc/modules for /etc/sysctl.conf configuration.

(Yes, it was ugly stuff.)

...

Well, this last point seemed like "ok, that's enough; we can do better."

I'm not sure this approach is "better" in all reasons, but hopefully it
might help starting something that is. 🙏

cheers,
Mauricio

...

Tests:

    $ cat /proc/sys/kernel/modprobe_sysctl_alias
    1
    
    $ cat /proc/sys/net/netfilter/nf_conntrack_max
    cat: /proc/sys/net/netfilter/nf_conntrack_max: No such file or directory
    
    $ lsmod | grep nf_conntrack
    $
    
    $ sudo modprobe sysctl:nf_conntrack_max
    
    $ cat /proc/sys/net/netfilter/nf_conntrack_max
    262144
    
    $ lsmod | grep nf_conntrack
    nf_conntrack          110592  0
    nf_defrag_ipv6         20480  1 nf_conntrack
    nf_defrag_ipv4         16384  1 nf_conntrack
    
    $ modinfo nf_conntrack | grep ^alias:
    alias:          nf_conntrack-10
    alias:          nf_conntrack-2
    alias:          ip_conntrack
    alias:          sysctl:nf_conntrack_icmpv6_timeout
    alias:          sysctl:nf_conntrack_icmp_timeout
    alias:          sysctl:nf_conntrack_udp_timeout_stream
    alias:          sysctl:nf_conntrack_udp_timeout
    alias:          sysctl:nf_conntrack_tcp_max_retrans
    alias:          sysctl:nf_conntrack_tcp_ignore_invalid_rst
    alias:          sysctl:nf_conntrack_tcp_be_liberal
    alias:          sysctl:nf_conntrack_tcp_loose
    alias:          sysctl:nf_conntrack_tcp_timeout_unacknowledged
    alias:          sysctl:nf_conntrack_tcp_timeout_max_retrans
    alias:          sysctl:nf_conntrack_tcp_timeout_close
    alias:          sysctl:nf_conntrack_tcp_timeout_time_wait
    alias:          sysctl:nf_conntrack_tcp_timeout_last_ack
    alias:          sysctl:nf_conntrack_tcp_timeout_close_wait
    alias:          sysctl:nf_conntrack_tcp_timeout_fin_wait
    alias:          sysctl:nf_conntrack_tcp_timeout_established
    alias:          sysctl:nf_conntrack_tcp_timeout_syn_recv
    alias:          sysctl:nf_conntrack_tcp_timeout_syn_sent
    alias:          sysctl:nf_conntrack_generic_timeout
    alias:          sysctl:nf_conntrack_helper
    alias:          sysctl:nf_conntrack_acct
    alias:          sysctl:nf_conntrack_expect_max
    alias:          sysctl:nf_conntrack_log_invalid
    alias:          sysctl:nf_conntrack_checksum
    alias:          sysctl:nf_conntrack_buckets
    alias:          sysctl:nf_conntrack_count
    alias:          sysctl:nf_conntrack_max
    
    $ modinfo r8169 | grep ^alias:
    alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
    alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
    alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
    alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
    alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
    alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
    alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
    alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
    alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
    alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
    alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*

Mauricio Faria de Oliveira (6):
  modpost: factor out elf/arch-specific code from section_rel[a]()
  modpost: deduplicate section_rel[a]()
  sysctl, mod_devicetable: shadow struct ctl_table.procname for
    file2alias
  module, modpost: introduce support for MODULE_SYSCTL_TABLE
  netfilter: conntrack: use MODULE_SYSCTL_TABLE
  sysctl: introduce /proc/sys/kernel/modprobe_sysctl_alias

 fs/proc/proc_sysctl.c                   |  27 ++++
 include/linux/mod_devicetable.h         |  25 ++++
 include/linux/module.h                  |   8 ++
 include/linux/sysctl.h                  |  11 +-
 kernel/sysctl.c                         |  10 ++
 net/netfilter/nf_conntrack_standalone.c |   4 +
 scripts/mod/devicetable-offsets.c       |   3 +
 scripts/mod/file2alias.c                | 111 +++++++++++++++
 scripts/mod/modpost.c                   | 178 +++++++++++++-----------
 scripts/mod/modpost.h                   |   3 +
 10 files changed, 296 insertions(+), 84 deletions(-)

-- 
2.25.1

