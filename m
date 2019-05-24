Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FFA29150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 08:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbfEXGvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 02:51:48 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34338 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388859AbfEXGvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 02:51:48 -0400
Received: by mail-wr1-f52.google.com with SMTP id f8so8761997wrt.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 23:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lltLW4PSxvyQGN9XyeiraZ/m6eO8W0SUMmn8vLH/4Ls=;
        b=sKNR8NY0tdHJd99RjxkPWy5xROELdQXkEYNdj/yXQrJN4FaQmVN45QCN+eIrSK75WP
         ksEV48A0KtcwdJ9WAYF86rYLYCVOGp1ezKwrE4l0l1vCYYNVlHTSH++X/aQ3RFdsCeix
         DHmQ8gtHyGsgVdOz549pXg1ADjYR26rUtPm1bnQJ2P7DUCn0HnaK8zR89jPQc34pKSRg
         B8cqAYAHnLDICrsEbLoGb8hyaqXQdIfKuCnlGo5AfN/607orQpVcUMFUjDEPKj4mJKsL
         i44CxLQJGkyq75HPyRtYgbniv5FkQXkM9PAvHFchZwf84BRgVR8P0Rlbi6P8v+/LPpxj
         o/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lltLW4PSxvyQGN9XyeiraZ/m6eO8W0SUMmn8vLH/4Ls=;
        b=TE/X3Q6Sn2NC16DUEjyaVlCJhIUfB4bq/UPl+NfWyWu/3/wXL46ZU+R7wnh2ETVLrT
         y3tKrIhYDLGRtBbr6a3S+/Tr8zO0YN6mTka7GQKOz8ooQUuso7M27BzXOHlUIbQuTMCK
         yVBhE1SuabixHXh49la6ftudOdLy+wB3MHL+mRCO0+7wHDwbqQzkStiC3EeGqbNGlXXY
         4+Z/vLoNLMvzO3XxZ01ezRZ87HisK2BP2T6Kn35+ziNcUASwnbQxVDkyytYD8QQLaHTO
         pwhG/rh6VLqDqiJKBQdTd2QTNss8kAYsnhNqX/PeH5uQEzTUKfS+t+g7NfTf7Fv2fyF4
         Ve2Q==
X-Gm-Message-State: APjAAAUNA76oI+1KsZNP6RFCP7/C065aWZDdC+GIsFni17/ndH0GmE8O
        P3ruerex2GzzvkSYGdA8G7GD3w==
X-Google-Smtp-Source: APXvYqzeAuKP4BywTT/svgg/pjDVaIDsDagPL3WmK/2Rp2Vr6wlLceTq/3SQUFtprD0lx72bBfsIvA==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr22137863wru.316.1558680704991;
        Thu, 23 May 2019 23:51:44 -0700 (PDT)
Received: from [192.168.0.100] (84-33-66-28.dyn.eolo.it. [84.33.66.28])
        by smtp.gmail.com with ESMTPSA id u2sm4345328wra.82.2019.05.23.23.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 23:51:43 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <E270AD92-943E-4529-8158-AB480D6D9DF8@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_85482289-FC7E-4B1A-B758-AC353CB4BF94";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Fri, 24 May 2019 08:51:41 +0200
In-Reply-To: <a04368ba-f1d5-8f2c-1279-a685a137d024@csail.mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
 <A0DFE635-EFEC-4670-AD70-5D813E170BEE@linaro.org>
 <5B6570A2-541A-4CF8-98E0-979EA6E3717D@linaro.org>
 <2CB39B34-21EE-4A95-A073-8633CF2D187C@linaro.org>
 <FC24E25F-4578-454D-AE2B-8D8D352478D8@linaro.org>
 <0e3fdf31-70d9-26eb-7b42-2795d4b03722@csail.mit.edu>
 <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
 <686D6469-9DE7-4738-B92A-002144C3E63E@linaro.org>
 <01d55216-5718-767a-e1e6-aadc67b632f4@csail.mit.edu>
 <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
 <cc148388-3c82-d7c0-f9ff-8c31bb5dc77d@csail.mit.edu>
 <6FE0A98F-1E3D-4EF6-8B38-2C85741924A4@linaro.org>
 <2A58C239-EF3F-422B-8D87-E7A3B500C57C@linaro.org>
 <a04368ba-f1d5-8f2c-1279-a685a137d024@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_85482289-FC7E-4B1A-B758-AC353CB4BF94
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 24 mag 2019, alle ore 01:43, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/23/19 10:22 AM, Paolo Valente wrote:
>>=20
>>> Il giorno 23 mag 2019, alle ore 11:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>>> Il giorno 23 mag 2019, alle ore 04:30, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>=20
> [...]
>>>> Also, I'm very happy to run additional tests or experiments to help
>>>> track down this issue. So, please don't hesitate to let me know if
>>>> you'd like me to try anything else or get you additional traces =
etc. :)
>>>>=20
>>>=20
>>> Here's to you!  :) I've attached a new small improvement that may
>>> reduce fluctuations (path to apply on top of the others, of course).
>>> Unfortunately, I don't expect this change to boost the throughput
>>> though.
>>>=20
>>> In contrast, I've thought of a solution that might be rather
>>> effective: making BFQ aware (heuristically) of trivial
>>> synchronizations between processes in different groups.  This will
>>> require a little more work and time.
>>>=20
>>=20
>> Hi Srivatsa,
>> I'm back :)
>>=20
>> First, there was a mistake in the last patch I sent you, namely in
>> 0001-block-bfq-re-sample-req-service-times-when-possible.patch.
>> Please don't apply that patch at all.
>>=20
>> I've attached a new series of patches instead.  The first patch in =
this
>> series is a fixed version of the faulty patch above (if I'm creating =
too
>> much confusion, I'll send you again all patches to apply on top of
>> mainline).
>>=20
>=20
> No problem, I got it :)
>=20
>> This series also implements the more effective idea I told you a few
>> hours ago.  In my system, the loss is now around only 10%, even with
>> low_latency on.
>>=20
>=20
> When trying to run multiple dd tasks simultaneously, I get the kernel
> panic shown below (mainline is fine, without these patches).
>=20

Could you please provide me somehow with a list =
*(bfq_serv_to_charge+0x21) ?

Thanks,
Paolo

> [  568.232231] BUG: kernel NULL pointer dereference, address: =
0000000000000024
> [  568.232257] #PF: supervisor read access in kernel mode
> [  568.232273] #PF: error_code(0x0000) - not-present page
> [  568.232289] PGD 0 P4D 0
> [  568.232299] Oops: 0000 [#1] SMP PTI
> [  568.232312] CPU: 0 PID: 1029 Comm: dd Tainted: G            E     =
5.1.0-io-dbg-4+ #6
> [  568.232334] Hardware name: VMware, Inc. VMware Virtual =
Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
> [  568.232388] RIP: 0010:bfq_serv_to_charge+0x21/0x50
> [  568.232404] Code: ff e8 c3 5e bc ff 0f 1f 00 0f 1f 44 00 00 48 8b =
86 20 01 00 00 55 48 89 e5 53 48 89 fb a8 40 75 09 83 be a0 01 00 00 01 =
76 09 <8b> 43 24 c1 e8 09 5b 5d c3 48 8b 7e 08 e8 5d fd ff ff 84 c0 75 =
ea
> [  568.232473] RSP: 0018:ffffa73a42dab750 EFLAGS: 00010002
> [  568.232489] RAX: 0000000000001052 RBX: 0000000000000000 RCX: =
ffffa73a42dab7a0
> [  568.232510] RDX: ffffa73a42dab657 RSI: ffff8b7b6ba2ab70 RDI: =
0000000000000000
> [  568.232530] RBP: ffffa73a42dab758 R08: 0000000000000000 R09: =
0000000000000001
> [  568.232551] R10: 0000000000000000 R11: ffffa73a42dab7a0 R12: =
ffff8b7b6aed3800
> [  568.232571] R13: 0000000000000000 R14: 0000000000000000 R15: =
ffff8b7b6aed3800
> [  568.232592] FS:  00007fb5b0724540(0000) GS:ffff8b7b6f800000(0000) =
knlGS:0000000000000000
> [  568.232615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  568.232632] CR2: 0000000000000024 CR3: 00000004266be002 CR4: =
00000000001606f0
> [  568.232690] Call Trace:
> [  568.232703]  bfq_select_queue+0x781/0x1000
> [  568.232717]  bfq_dispatch_request+0x1d7/0xd60
> [  568.232731]  ? bfq_bfqq_handle_idle_busy_switch.isra.36+0x2cd/0xb20
> [  568.232751]  blk_mq_do_dispatch_sched+0xa8/0xe0
> [  568.232765]  blk_mq_sched_dispatch_requests+0xe3/0x150
> [  568.232783]  __blk_mq_run_hw_queue+0x56/0x100
> [  568.232798]  __blk_mq_delay_run_hw_queue+0x107/0x160
> [  568.232814]  blk_mq_run_hw_queue+0x75/0x190
> [  568.232828]  blk_mq_sched_insert_requests+0x7a/0x100
> [  568.232844]  blk_mq_flush_plug_list+0x1d7/0x280
> [  568.232859]  blk_flush_plug_list+0xc2/0xe0
> [  568.232872]  blk_finish_plug+0x2c/0x40
> [  568.232886]  ext4_writepages+0x592/0xe60
> [  568.233381]  ? ext4_mark_iloc_dirty+0x52b/0x860
> [  568.233851]  do_writepages+0x3c/0xd0
> [  568.234304]  ? ext4_mark_inode_dirty+0x1a0/0x1a0
> [  568.234748]  ? do_writepages+0x3c/0xd0
> [  568.235197]  ? __generic_write_end+0x4e/0x80
> [  568.235644]  __filemap_fdatawrite_range+0xa5/0xe0
> [  568.236089]  ? __filemap_fdatawrite_range+0xa5/0xe0
> [  568.236533]  ? ext4_da_write_end+0x13c/0x280
> [  568.236983]  file_write_and_wait_range+0x5a/0xb0
> [  568.237407]  ext4_sync_file+0x11e/0x3e0
> [  568.237819]  vfs_fsync_range+0x48/0x80
> [  568.238217]  ext4_file_write_iter+0x234/0x3d0
> [  568.238610]  ? _cond_resched+0x19/0x40
> [  568.238982]  new_sync_write+0x112/0x190
> [  568.239347]  __vfs_write+0x29/0x40
> [  568.239705]  vfs_write+0xb1/0x1a0
> [  568.240078]  ksys_write+0x89/0xc0
> [  568.240428]  __x64_sys_write+0x1a/0x20
> [  568.240771]  do_syscall_64+0x5b/0x140
> [  568.241115]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  568.241456] RIP: 0033:0x7fb5b02325f4
> [  568.241787] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f =
1f 80 00 00 00 00 48 8d 05 09 11 2d 00 8b 00 85 c0 75 13 b8 01 00 00 00 =
0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 =
f5
> [  568.242842] RSP: 002b:00007ffcb12e2968 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
> [  568.243220] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007fb5b02325f4
> [  568.243616] RDX: 0000000000000200 RSI: 000055698f2ad000 RDI: =
0000000000000001
> [  568.244026] RBP: 0000000000000200 R08: 0000000000000004 R09: =
0000000000000003
> [  568.244401] R10: 00007fb5b04feca0 R11: 0000000000000246 R12: =
000055698f2ad000
> [  568.244775] R13: 0000000000000000 R14: 0000000000000000 R15: =
000055698f2ad000
> [  568.245154] Modules linked in: xt_MASQUERADE(E) =
nf_conntrack_netlink(E) nfnetlink(E) xfrm_user(E) xfrm_algo(E) =
xt_addrtype(E) br_netfilter(E) bridge(E) stp(E) llc(E) overlay(E) =
vmw_vsock_vmci_transport(E) vsock(E) ip6table_filter(E) ip6_tables(E) =
xt_conntrack(E) iptable_mangle(E) iptable_nat(E) nf_nat(E) =
iptable_filter
> [  568.248651] CR2: 0000000000000024
> [  568.249142] ---[ end trace 0ddd315e0a5bdfba ]---
>=20
>=20
> Regards,
> Srivatsa
> VMware Photon OS


--Apple-Mail=_85482289-FC7E-4B1A-B758-AC353CB4BF94
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlznlH0ACgkQOAkCLQGo
9oP7Kg//QHKt9Jzd3acqyDErdMmFS2yVJJYS8+gQCTLa0fu44rQYs7wiCipLNKdI
rrymUh3KYssp2iTE23wVHZ36OfkU0157yzztHAoguyq2CNMFfTYv+T7lx3803In3
KS9QalPnIpm5K1ectGfCtcXb8QZt/ZAJ1mZDhhphQEIx9dOqmW1+tehihzgzW0K1
vKIk9DaN4/WcE7yeQCtaD7gJI4TWKaKhwDfH+BmfjMg0OvU4xOjaJFSvjH/C+OWp
Mw9DIDt+Ne638wKuPPsH1aEtZxR/G0Z+wHy+CuAyikt4KTDm4dGcHpGR99Rhb6IY
LOeHKWUD0JyeJs5oQdUFL8fRNu2i7LhOVVJKuOdW99yvWNe/zzY9fgaPzt78itNS
SiKvkQAqKYHtVkk8RW3+U3HbXR1v0vV62nhbBgrSF9qhVecvRgeYhzBVl6ZkAo5z
UwiIRjQgzsbUDrnHjrzYxGb45sJxkC+WJRxTf95hJ3y842uy7ML6YBNHmfWDi5d+
3xsV1qvIvSyMaj/NryCRbRqM1XseyiQGw+gSSqUAbhCgPEVhPAzn3sUYizz2DVAi
VQAUAOvo4bq1UJqM8AMTYItdgG4PqMafRPGDQY9wQ0emWyc8Qsb99Lm9rvhOG0Ou
IDRcISk/XZTXb/M0nuaMIJ6pP1IjsAGOXyWk6wADOD8Gn5WarRE=
=5NSm
-----END PGP SIGNATURE-----

--Apple-Mail=_85482289-FC7E-4B1A-B758-AC353CB4BF94--
