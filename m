Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271E6C9A14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 05:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjC0DWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 23:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjC0DUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:20:16 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030E5584;
        Sun, 26 Mar 2023 20:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679887161; i=@fujitsu.com;
        bh=6GgxWwWX/BOTSus+PH03NGL9vRqqI6bAI75lExOYDI0=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=KvzMfdWVObifY+C+tGdOEHqwa4KO7t1OiZn/I1z4T3sAtnh/Fb2gYSS7EHlbgnIZK
         403i3zks5qWPo32Bp4MfM62YoJazIyELOPn++X3lE+b2LwhHEGo6klVvJeYxPSSJIm
         ZgNWQvjhOeC5w1gb0WmFwYfszaGbMCO91PLr61hV+tVptk/M28ZShIr1+Ly9hzm45t
         NTmNuR8uJ0VLUFkbEy5kxNjvxoWLAtY16fcQv1DmYWENfXA22h/F5xNd+opS4pH91y
         mJWXWr/y/nAmRqYyk5W181uzMjfH4DtLfxoaDaLHXjoJ6+3e+fE53HclbaEU5SB3+v
         hiNhSiZRYyT9w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRWlGSWpSXmKPExsViZ8ORqKvHrZh
  i8OixvsWc9WvYLKZPvcBocfkJn8Xs6c1MFnv2nmSx2PVnB7vFyh9/WC1+/5jD5sDhsXmFlsfi
  PS+ZPDat6mTzODHjN4vHi80zGT3OLDjC7vF5k1wAexRrZl5SfkUCa8aUjrnMBbtkKjbMamVvY
  Dwk3sXIxSEksIVR4vGPkywQznImib3NP6GcbYwSR/8cZu5i5OTgFbCTuP22iRHEZhFQlTi69A
  UTRFxQ4uTMJywgtqhAssSx861sILawgKXErW+XwGwRAV2JVc93MYMMZQZZN/XAb1aIDc2MEv8
  OrWYFqWIT0JG4sOAvkM3BwSngLXH+czBImFnAQmLxm4PsELa8RPPW2WAHSQgoSVz8eocVwq6Q
  aJx+iAnCVpO4em4T8wRGoVlI7puFZNQsJKMWMDKvYjQtTi0qSy3SNdVLKspMzyjJTczM0Uus0
  k3USy3VLU8tLtE11EssL9ZLLS7WK67MTc5J0ctLLdnECIy1lGIWsx2M7X1/9Q4xSnIwKYny9n
  MqpgjxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4L3FAZQTLEpNT61Iy8wBxj1MWoKDR0mEdxNIK29
  xQWJucWY6ROoUoy7HhgcH9jILseTl56VKifN6cwEVCYAUZZTmwY2ApaBLjLJSwryMDAwMQjwF
  qUW5mSWo8q8YxTkYlYR5J4Os4snMK4Hb9AroCCagI74VKIAcUZKIkJJqYLJVcf6ZFbum9K3nx
  myNbXVBukev5rxK+doVO81F7uz042Yd0YctJzuveyh6+1xa/YToSq5dLQI9Tu+lnXRPfeFnVK
  4+sDN+6oHApdv3OZ8TUL8vPMvh66TyK4pTrs6yCnn5bOr+9I3qnSv5pxn89Fj5R9r8x4v3cqK
  RCf9P/45JPy2wgVed79S6gv2OqTeDblceEDCq+/WN77PEx2W7mDpDls7iXBtvLLs1r+jV7/pe
  od6OHYVvX058kxjNEFz/ag1bGVvs97riUuXdGe8eqpoui+1M2HNwr4r2gveTXENPHVUyuuGlN
  rVR7HmsutH5mytZak8F/K2dPWmr4J+Ss2p/z0SoqT4zMVcX6VdpL1NiKc5INNRiLipOBACkdn
  ZZvAMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-11.tower-587.messagelabs.com!1679887150!419166!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4069 invoked from network); 27 Mar 2023 03:19:10 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-11.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Mar 2023 03:19:10 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 56B401001A3;
        Mon, 27 Mar 2023 04:19:10 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 4A25E100194;
        Mon, 27 Mar 2023 04:19:10 +0100 (BST)
Received: from [192.168.50.5] (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 27 Mar 2023 04:19:07 +0100
Message-ID: <05b9f49f-16ce-be40-4d42-049f8b3825c5@fujitsu.com>
Date:   Mon, 27 Mar 2023 11:19:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] fsdax: force clear dirty mark if CoW
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <djwong@kernel.org>
References: <1679653680-2-1-git-send-email-ruansy.fnst@fujitsu.com>
 <20230324124242.c881cf384ab8a37716850413@linux-foundation.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20230324124242.c881cf384ab8a37716850413@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2023/3/25 3:42, Andrew Morton 写道:
> On Fri, 24 Mar 2023 10:28:00 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
>> XFS allows CoW on non-shared extents to combat fragmentation[1].  The
>> old non-shared extent could be mwrited before, its dax entry is marked
>> dirty.  To be able to delete this entry, clear its dirty mark before
>> invalidate_inode_pages2_range().
> 
> What are the user-visible runtime effects of this flaw?

This bug won't leak or mess up the data of filesystem.  In dmesg it will 
show like this:

[   28.512349] ------------[ cut here ]------------
[   28.512622] WARNING: CPU: 2 PID: 5255 at fs/dax.c:390 
dax_insert_entry+0x342/0x390
[   28.513050] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs 
lockd grace fscache netfs nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables
[   28.515462] CPU: 2 PID: 5255 Comm: fsstress Kdump: loaded Not tainted 
6.3.0-rc1-00001-g85e1481e19c1-dirty #117
[   28.515902] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
Arch Linux 1.16.1-1-1 04/01/2014
[   28.516307] RIP: 0010:dax_insert_entry+0x342/0x390
[   28.516536] Code: 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 
8b 45 20 48 83 c0 01 e9 e2 fe ff ff 48 8b 45 20 48 83 c0 01 e9 cd fe ff 
ff <0f> 0b e9 53 ff ff ff 48 8b 7c 24 08 31 f6 e8 1b 61 a1 00 eb 8c 48
[   28.517417] RSP: 0000:ffffc9000845fb18 EFLAGS: 00010086
[   28.517721] RAX: 0000000000000053 RBX: 0000000000000155 RCX: 
000000000018824b
[   28.518113] RDX: 0000000000000000 RSI: ffffffff827525a6 RDI: 
00000000ffffffff
[   28.518515] RBP: ffffea00062092c0 R08: 0000000000000000 R09: 
ffffc9000845f9c8
[   28.518905] R10: 0000000000000003 R11: ffffffff82ddb7e8 R12: 
0000000000000155
[   28.519301] R13: 0000000000000000 R14: 000000000018824b R15: 
ffff88810cfa76b8
[   28.519703] FS:  00007f14a0c94740(0000) GS:ffff88817bd00000(0000) 
knlGS:0000000000000000
[   28.520148] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.520472] CR2: 00007f14a0c8d000 CR3: 000000010321c004 CR4: 
0000000000770ee0
[   28.520863] PKRU: 55555554
[   28.521043] Call Trace:
[   28.521219]  <TASK>
[   28.521368]  dax_fault_iter+0x196/0x390
[   28.521595]  dax_iomap_pte_fault+0x19b/0x3d0
[   28.521852]  __xfs_filemap_fault+0x234/0x2b0
[   28.522116]  __do_fault+0x30/0x130
[   28.522334]  do_fault+0x193/0x340
[   28.522586]  __handle_mm_fault+0x2d3/0x690
[   28.522975]  handle_mm_fault+0xe6/0x2c0
[   28.523259]  do_user_addr_fault+0x1bc/0x6f0
[   28.523521]  exc_page_fault+0x60/0x140
[   28.523763]  asm_exc_page_fault+0x22/0x30
[   28.524001] RIP: 0033:0x7f14a0b589ca
[   28.524225] Code: c5 fe 7f 07 c5 fe 7f 47 20 c5 fe 7f 47 40 c5 fe 7f 
47 60 c5 f8 77 c3 66 0f 1f 84 00 00 00 00 00 40 0f b6 c6 48 89 d1 48 89 
fa <f3> aa 48 89 d0 c5 f8 77 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90
[   28.525198] RSP: 002b:00007fff1dea1c98 EFLAGS: 00010202
[   28.525505] RAX: 000000000000001e RBX: 000000000014a000 RCX: 
0000000000006046
[   28.525895] RDX: 00007f14a0c82000 RSI: 000000000000001e RDI: 
00007f14a0c8d000
[   28.526290] RBP: 000000000000006f R08: 0000000000000004 R09: 
000000000014a000
[   28.526681] R10: 0000000000000008 R11: 0000000000000246 R12: 
028f5c28f5c28f5c
[   28.527067] R13: 8f5c28f5c28f5c29 R14: 0000000000011046 R15: 
00007f14a0c946c0
[   28.527449]  </TASK>
[   28.527600] ---[ end trace 0000000000000000 ]---

 >
 > Are we able to identify a Fixes: target for this?  Perhaps
 > f80e1668888f3 ("fsdax: invalidate pages when CoW")?
 >

Yes, it is to fix this commit.


--
Thanks,
Ruan.
