Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37352D697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfE2HlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 03:41:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52417 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfE2HlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 03:41:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so849840wmm.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=SOy3B69zClHnFybJMv8XI3Olw2skCEmEA1+tMUtIH0I=;
        b=safvrxifA82sUE1Dw036tt/ISyC+sByTQSLTH6TjRNc5bASOjOtJ1y+wJz+6vw1xiz
         CgsT0QA9bFy5sZihY8HgVo2P5g3m00WFcb4r6xpp/cPgtcYvR+i3Ht83XLdP/mLXv4jH
         jqWhFYa2817Jud+CFJAzieFknry94eWp8oX3BcoRWyevRB/Ad7iT/tzFy6wRrunjKe63
         FxlIO3FXcMgCVMq8yuiBxONoMchIaf0OctxP5Vulmn2MjPj7b0iG1EspRiQHjI3Sj7Gg
         9u80ALo7aOFuS3FfZPXBYXDm30VBqlOHj0v+CdXUCBJ+JGQhR94y+AwxLRdfb4i2/sMn
         YtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=SOy3B69zClHnFybJMv8XI3Olw2skCEmEA1+tMUtIH0I=;
        b=RKcBhK3JuIHiwujJgRpGvnI+mp1D74/lKexFpWa5/XoJ3QiGzYVBayC6O2caOOvBYk
         3l9yVtUzKL/KeeQoDavwEv1yYBJJb7SL9oJ9rLbLS5s9NjOBsPF0HM0+PvlcHH2P+/k3
         bZX3nJiFThovMvoMrPTX5LvTKz3+OyAgGjjNEOHRYeOjfHdnlEodeqC+fXY5wbRbJf/D
         DdD889VADPoFKrAQOGPFQWAJ5EPmQjX36Iyst2iniq3kaCJxS8dBnrOfjBActva3lS6T
         QttAmbsygjxEo8FWEv9symKsoRlT++sJyTFcFyxDvv5H7+wmNZJjaKW9NrsPk5Axf4Ri
         6flA==
X-Gm-Message-State: APjAAAUBhj4PGG6M+tJ7KjdaI/M43PZXcsMgeixb2+E3KvbnKnL0FwOh
        Mox5mGX8n6v6TLrp5KwYGgl4OkHGVYQ=
X-Google-Smtp-Source: APXvYqx/HwYaphNMYLWw3ilkoWGV18NWchGd2FGjB0PW0vabDn4hudBso/z+incwZMw9HS3pFa4sTQ==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr6183006wmb.112.1559115680026;
        Wed, 29 May 2019 00:41:20 -0700 (PDT)
Received: from [192.168.0.100] (146-241-114-97.dyn.eolo.it. [146.241.114.97])
        by smtp.gmail.com with ESMTPSA id n10sm21383362wrr.11.2019.05.29.00.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 00:41:19 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <FFA44D26-75FF-4A8E-A331-495349BE5FFC@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_88874A7E-B5F0-4892-B8A9-16FC260C00C1";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Wed, 29 May 2019 09:41:17 +0200
In-Reply-To: <5b71028c-72f0-73dd-0cd5-f28ff298a0a3@csail.mit.edu>
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
 <E270AD92-943E-4529-8158-AB480D6D9DF8@linaro.org>
 <5b71028c-72f0-73dd-0cd5-f28ff298a0a3@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_88874A7E-B5F0-4892-B8A9-16FC260C00C1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 29 mag 2019, alle ore 03:09, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/23/19 11:51 PM, Paolo Valente wrote:
>>=20
>>> Il giorno 24 mag 2019, alle ore 01:43, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>=20
>>> When trying to run multiple dd tasks simultaneously, I get the =
kernel
>>> panic shown below (mainline is fine, without these patches).
>>>=20
>>=20
>> Could you please provide me somehow with a list =
*(bfq_serv_to_charge+0x21) ?
>>=20
>=20
> Hi Paolo,
>=20
> Sorry for the delay! Here you go:
>=20
> (gdb) list *(bfq_serv_to_charge+0x21)
> 0xffffffff814bad91 is in bfq_serv_to_charge =
(./include/linux/blkdev.h:919).
> 914
> 915	extern unsigned int blk_rq_err_bytes(const struct request *rq);
> 916
> 917	static inline unsigned int blk_rq_sectors(const struct request =
*rq)
> 918	{
> 919		return blk_rq_bytes(rq) >> SECTOR_SHIFT;
> 920	}
> 921
> 922	static inline unsigned int blk_rq_cur_sectors(const struct =
request *rq)
> 923	{
> (gdb)
>=20
>=20
> For some reason, I've not been able to reproduce this issue after
> reporting it here. (Perhaps I got lucky when I hit the kernel panic
> a bunch of times last week).
>=20
> I'll test with your fix applied and see how it goes.
>=20

Great!  the offending line above gives me hope that my fix is correct.
If no more failures occur, then I'm eager (and a little worried ...)
to see how it goes with throughput :)

Thanks,
Paolo

> Thank you!
>=20
> Regards,
> Srivatsa
>=20
>>=20
>>> [  568.232231] BUG: kernel NULL pointer dereference, address: =
0000000000000024
>>> [  568.232257] #PF: supervisor read access in kernel mode
>>> [  568.232273] #PF: error_code(0x0000) - not-present page
>>> [  568.232289] PGD 0 P4D 0
>>> [  568.232299] Oops: 0000 [#1] SMP PTI
>>> [  568.232312] CPU: 0 PID: 1029 Comm: dd Tainted: G            E     =
5.1.0-io-dbg-4+ #6
>>> [  568.232334] Hardware name: VMware, Inc. VMware Virtual =
Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
>>> [  568.232388] RIP: 0010:bfq_serv_to_charge+0x21/0x50
>>> [  568.232404] Code: ff e8 c3 5e bc ff 0f 1f 00 0f 1f 44 00 00 48 8b =
86 20 01 00 00 55 48 89 e5 53 48 89 fb a8 40 75 09 83 be a0 01 00 00 01 =
76 09 <8b> 43 24 c1 e8 09 5b 5d c3 48 8b 7e 08 e8 5d fd ff ff 84 c0 75 =
ea
>>> [  568.232473] RSP: 0018:ffffa73a42dab750 EFLAGS: 00010002
>>> [  568.232489] RAX: 0000000000001052 RBX: 0000000000000000 RCX: =
ffffa73a42dab7a0
>>> [  568.232510] RDX: ffffa73a42dab657 RSI: ffff8b7b6ba2ab70 RDI: =
0000000000000000
>>> [  568.232530] RBP: ffffa73a42dab758 R08: 0000000000000000 R09: =
0000000000000001
>>> [  568.232551] R10: 0000000000000000 R11: ffffa73a42dab7a0 R12: =
ffff8b7b6aed3800
>>> [  568.232571] R13: 0000000000000000 R14: 0000000000000000 R15: =
ffff8b7b6aed3800
>>> [  568.232592] FS:  00007fb5b0724540(0000) GS:ffff8b7b6f800000(0000) =
knlGS:0000000000000000
>>> [  568.232615] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  568.232632] CR2: 0000000000000024 CR3: 00000004266be002 CR4: =
00000000001606f0
>>> [  568.232690] Call Trace:
>>> [  568.232703]  bfq_select_queue+0x781/0x1000
>>> [  568.232717]  bfq_dispatch_request+0x1d7/0xd60
>>> [  568.232731]  ? =
bfq_bfqq_handle_idle_busy_switch.isra.36+0x2cd/0xb20
>>> [  568.232751]  blk_mq_do_dispatch_sched+0xa8/0xe0
>>> [  568.232765]  blk_mq_sched_dispatch_requests+0xe3/0x150
>>> [  568.232783]  __blk_mq_run_hw_queue+0x56/0x100
>>> [  568.232798]  __blk_mq_delay_run_hw_queue+0x107/0x160
>>> [  568.232814]  blk_mq_run_hw_queue+0x75/0x190
>>> [  568.232828]  blk_mq_sched_insert_requests+0x7a/0x100
>>> [  568.232844]  blk_mq_flush_plug_list+0x1d7/0x280
>>> [  568.232859]  blk_flush_plug_list+0xc2/0xe0
>>> [  568.232872]  blk_finish_plug+0x2c/0x40
>>> [  568.232886]  ext4_writepages+0x592/0xe60
>>> [  568.233381]  ? ext4_mark_iloc_dirty+0x52b/0x860
>>> [  568.233851]  do_writepages+0x3c/0xd0
>>> [  568.234304]  ? ext4_mark_inode_dirty+0x1a0/0x1a0
>>> [  568.234748]  ? do_writepages+0x3c/0xd0
>>> [  568.235197]  ? __generic_write_end+0x4e/0x80
>>> [  568.235644]  __filemap_fdatawrite_range+0xa5/0xe0
>>> [  568.236089]  ? __filemap_fdatawrite_range+0xa5/0xe0
>>> [  568.236533]  ? ext4_da_write_end+0x13c/0x280
>>> [  568.236983]  file_write_and_wait_range+0x5a/0xb0
>>> [  568.237407]  ext4_sync_file+0x11e/0x3e0
>>> [  568.237819]  vfs_fsync_range+0x48/0x80
>>> [  568.238217]  ext4_file_write_iter+0x234/0x3d0
>>> [  568.238610]  ? _cond_resched+0x19/0x40
>>> [  568.238982]  new_sync_write+0x112/0x190
>>> [  568.239347]  __vfs_write+0x29/0x40
>>> [  568.239705]  vfs_write+0xb1/0x1a0
>>> [  568.240078]  ksys_write+0x89/0xc0
>>> [  568.240428]  __x64_sys_write+0x1a/0x20
>>> [  568.240771]  do_syscall_64+0x5b/0x140
>>> [  568.241115]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> [  568.241456] RIP: 0033:0x7fb5b02325f4
>>> [  568.241787] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f =
1f 80 00 00 00 00 48 8d 05 09 11 2d 00 8b 00 85 c0 75 13 b8 01 00 00 00 =
0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 =
f5
>>> [  568.242842] RSP: 002b:00007ffcb12e2968 EFLAGS: 00000246 ORIG_RAX: =
0000000000000001
>>> [  568.243220] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: =
00007fb5b02325f4
>>> [  568.243616] RDX: 0000000000000200 RSI: 000055698f2ad000 RDI: =
0000000000000001
>>> [  568.244026] RBP: 0000000000000200 R08: 0000000000000004 R09: =
0000000000000003
>>> [  568.244401] R10: 00007fb5b04feca0 R11: 0000000000000246 R12: =
000055698f2ad000
>>> [  568.244775] R13: 0000000000000000 R14: 0000000000000000 R15: =
000055698f2ad000
>>> [  568.245154] Modules linked in: xt_MASQUERADE(E) =
nf_conntrack_netlink(E) nfnetlink(E) xfrm_user(E) xfrm_algo(E) =
xt_addrtype(E) br_netfilter(E) bridge(E) stp(E) llc(E) overlay(E) =
vmw_vsock_vmci_transport(E) vsock(E) ip6table_filter(E) ip6_tables(E) =
xt_conntrack(E) iptable_mangle(E) iptable_nat(E) nf_nat(E) =
iptable_filter
>>> [  568.248651] CR2: 0000000000000024
>>> [  568.249142] ---[ end trace 0ddd315e0a5bdfba ]---
>>>=20


--Apple-Mail=_88874A7E-B5F0-4892-B8A9-16FC260C00C1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzuN50ACgkQOAkCLQGo
9oOyVxAAiJh/RlNWNerXrJ2E+eEQCMmQPRoqJEZ3Jr93GqJ1Y8/XqR7efG2rX90H
rgqYU/rzcZgANERdk99Z2wJHF/W2tO+f7OZ2iGB3NetMvny9YS+8R0bcaH6b8uZQ
pRwOrC2wbGNCApvbPP9Gm85SgJggEdeFWNkN9UcMgJwfsWvR0tIWUWiYppDMsuQs
JcTfX4glwOm5RUjXAYslIqNm2bYRpBWbYM0zr+YrjvoipKwj/gkzur3B3htn3Pqj
PNBAH1O0684ZkRTOMaDM/OQxNv5BlgDXvEuAoih0kS3aSk+H/JPiacJ5iUaa+j1u
d7UR3/OPsq5zM351WmcCvkBbLSqqQlBeNo0Nktm1/CAQ4I+F7Z+IYWgLtCSqgXPw
BG4mdupvQnFK6wb08xBd9C7CfSO2rQyGYn95Gg+eFpmcwZ+VWQPZyKqmDxN/0zW9
5ERe0EHJUePOmHtrpmfcqcltT2pkvNNqGnz6F0cY7u9vZcHxjRSKaLltgUJzRjwZ
hJzjif8W1GR3wrSV/mICFU2RBujBPnIaR0XMG+UAsTl0PzFPM5ICLV5ws5wnSnFk
WZaOYPmQgI64j/N0B5BV0EccxVUstWizDuKtDDFMWvfNs9rjeQDaShUzL7r0g2gx
IRVDdj9POK11csHsato4TZzMDXj3nzMtMRbj8b8dim3DIS0zjHM=
=DNH0
-----END PGP SIGNATURE-----

--Apple-Mail=_88874A7E-B5F0-4892-B8A9-16FC260C00C1--
