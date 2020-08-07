Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB523F4B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 00:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHGWBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgHGWBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 18:01:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59BC061756
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2020 15:01:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so1663320pjb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Aug 2020 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=hs3HY7g7iInOHSIqlAQOKkHaLJM+XTGFYI2JrFlwSao=;
        b=KYkemN3wBNlYDhhXvoWTtxkp87n/L1OvrCWlndyuEBoUjl6bk34DFVxYJL4b55g9xJ
         lpv37WwWkemyIThrNYa4CMAh2RoW2z/aUnNeeU3/IxMNI0Aqls51tIS7Zv9ZFeII2/SQ
         fNSdGdByo75xXLs1dxQkgPG+U9E+br6Y38HhhGUJZ2/d45wwzwQSLicDqdn7RLaM/1yM
         v0fKGN88M0uJbg11r+YY6HcC2xg/Oof1oDql8NHHvi5czh2f+V69rmOImdkBS5PESulX
         9xic0OyQB+WJhST3ajFx37Ax+kCEw99S7oaPEZMTl+QU/XPJcLdv9fhiEAF+iWIYBopM
         m4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=hs3HY7g7iInOHSIqlAQOKkHaLJM+XTGFYI2JrFlwSao=;
        b=HNuLAuCyDb6Ijz1ECd4py63QbIfrZ7zUovyqUNvqg9vTEzY64XQq5foyX+kqSKoj/v
         emamObZ3ZYw9xKwkr3HUM90VBaIp/92cf94Mxme3VngWtzO9/KJYZ5q31lI9OhXflDga
         lS1wrAgWgpWXxkzN4CmJijcbCBSsv3m1KYDVm2J35BGdgLrmWqX5erJ7HntnyR4fgzSJ
         BhPlWPJxdE2hNtBRtuNADVJ33ufJkPK5ryJfox/nDeNfKTDhXRRElabaZrjQ7lVsxzza
         cDICFUqIG5txJV/7feOpK78Pn55MOJy37pMDamvfgErRHdZIKcpyvmAKtBZeljVlbJX1
         dxzw==
X-Gm-Message-State: AOAM532nTbSn/ZDvpkHG3aPu0g9HWvynIZ5tZG73TpGFx2DrA8zgFZsD
        zBQJQWJgaNT0hkxBhlr9JoLr0g==
X-Google-Smtp-Source: ABdhPJzoMQhhi/rBSj/WDXaIUN0MEnwJEXr2mImjjgwCOzE1luZhFQk56pBe+POKwCpRV2CwOWvLZg==
X-Received: by 2002:a17:90a:628b:: with SMTP id d11mr14776004pjj.167.1596837695527;
        Fri, 07 Aug 2020 15:01:35 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f13sm13925917pfd.215.2020.08.07.15.01.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 15:01:34 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1E54BAC3-43E0-4908-97A1-6F33D9F353C3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_713A9422-50CF-4793-BBFA-A646EEB0262C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: move buffer_mapped() to proper position
Date:   Fri, 7 Aug 2020 16:01:42 -0600
In-Reply-To: <20200807200254.GY7657@mit.edu>
Cc:     Xianting Tian <xianting_tian@126.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <1596211825-8750-1-git-send-email-xianting_tian@126.com>
 <20200807200254.GY7657@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_713A9422-50CF-4793-BBFA-A646EEB0262C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Aug 7, 2020, at 2:02 PM, tytso@mit.edu wrote:
>=20
> Thanks, applied, although I rewrote the commit description to make it
> be a bit more clearer:
>=20
>    fs: prevent BUG_ON in submit_bh_wbc()
>=20
>    If a device is hot-removed --- for example, when a physical device =
is
>    unplugged from pcie slot or a nbd device's network is shutdown ---
>    this can result in a BUG_ON() crash in submit_bh_wbc().  This is
>    because the when the block device dies, the buffer heads will have
>    their Buffer_Mapped flag get cleared, leading to the crash in
>    submit_bh_wbc.
>=20
>    We had attempted to work around this problem in commit a17712c8

Should this get a "Fixes:" label with this info, rather than embedding
it in the commit message, so that it could be picked up by stable?

Cheers, Andreas

>    ("ext4: check superblock mapped prior to committing").  =
Unfortunately,
>    it's still possible to hit the BUG_ON(!buffer_mapped(bh)) if the
>    device dies between when the work-around check in =
ext4_commit_super()
>    and when submit_bh_wbh() is finally called:
>=20
>    Code path:
>    ext4_commit_super
>        judge if 'buffer_mapped(sbh)' is false, return <=3D=3D commit =
a17712c8
>              lock_buffer(sbh)
>              ...
>              unlock_buffer(sbh)
>                   __sync_dirty_buffer(sbh,...
>                        lock_buffer(sbh)
>                            judge if 'buffer_mapped(sbh))' is false, =
return <=3D=3D added by this patch
>                                submit_bh(...,sbh)
>                                    submit_bh_wbc(...,sbh,...)
>=20
>    [100722.966497] kernel BUG at fs/buffer.c:3095! <=3D=3D =
BUG_ON(!buffer_mapped(bh))' in submit_bh_wbc()
>    [100722.966503] invalid opcode: 0000 [#1] SMP
>    [100722.966566] task: ffff8817e15a9e40 task.stack: ffffc90024744000
>    [100722.966574] RIP: 0010:submit_bh_wbc+0x180/0x190
>    [100722.966575] RSP: 0018:ffffc90024747a90 EFLAGS: 00010246
>    [100722.966576] RAX: 0000000000620005 RBX: ffff8818a80603a8 RCX: =
0000000000000000
>    [100722.966576] RDX: ffff8818a80603a8 RSI: 0000000000020800 RDI: =
0000000000000001
>    [100722.966577] RBP: ffffc90024747ac0 R08: 0000000000000000 R09: =
ffff88207f94170d
>    [100722.966578] R10: 00000000000437c8 R11: 0000000000000001 R12: =
0000000000020800
>    [100722.966578] R13: 0000000000000001 R14: 000000000bf9a438 R15: =
ffff88195f333000
>    [100722.966580] FS:  00007fa2eee27700(0000) =
GS:ffff88203d840000(0000) knlGS:0000000000000000
>    [100722.966580] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [100722.966581] CR2: 0000000000f0b008 CR3: 000000201a622003 CR4: =
00000000007606e0
>    [100722.966582] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>    [100722.966583] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>    [100722.966583] PKRU: 55555554
>    [100722.966583] Call Trace:
>    [100722.966588]  __sync_dirty_buffer+0x6e/0xd0
>    [100722.966614]  ext4_commit_super+0x1d8/0x290 [ext4]
>    [100722.966626]  __ext4_std_error+0x78/0x100 [ext4]
>    [100722.966635]  ? __ext4_journal_get_write_access+0xca/0x120 =
[ext4]
>    [100722.966646]  ext4_reserve_inode_write+0x58/0xb0 [ext4]
>    [100722.966655]  ? ext4_dirty_inode+0x48/0x70 [ext4]
>    [100722.966663]  ext4_mark_inode_dirty+0x53/0x1e0 [ext4]
>    [100722.966671]  ? __ext4_journal_start_sb+0x6d/0xf0 [ext4]
>    [100722.966679]  ext4_dirty_inode+0x48/0x70 [ext4]
>    [100722.966682]  __mark_inode_dirty+0x17f/0x350
>    [100722.966686]  generic_update_time+0x87/0xd0
>    [100722.966687]  touch_atime+0xa9/0xd0
>    [100722.966690]  generic_file_read_iter+0xa09/0xcd0
>    [100722.966694]  ? page_cache_tree_insert+0xb0/0xb0
>    [100722.966704]  ext4_file_read_iter+0x4a/0x100 [ext4]
>    [100722.966707]  ? __inode_security_revalidate+0x4f/0x60
>    [100722.966709]  __vfs_read+0xec/0x160
>    [100722.966711]  vfs_read+0x8c/0x130
>    [100722.966712]  SyS_pread64+0x87/0xb0
>    [100722.966716]  do_syscall_64+0x67/0x1b0
>    [100722.966719]  entry_SYSCALL64_slow_path+0x25/0x25
>=20
>    To address this, add the check of 'buffer_mapped(bh)' to
>    __sync_dirty_buffer().  This also has the benefit of fixing this =
for
>    other file systems.
>=20
>    With this addition, we can drop the workaround in =
ext4_commit_supper().
>=20
>    [ Commit description rewritten by tytso. ]
>=20
>    Signed-off-by: Xianting Tian <xianting_tian@126.com>
>    Link: =
https://lore.kernel.org/r/1596211825-8750-1-git-send-email-xianting_tian@1=
26.com
>    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>=20
> 							- Ted


Cheers, Andreas






--Apple-Mail=_713A9422-50CF-4793-BBFA-A646EEB0262C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8tz0YACgkQcqXauRfM
H+Ct9w//USImy+Og8ALzibs973+iX2GUBoGOsZGwszW8GFptFk8/my3ltdbeU0xs
rXakgWy55lpnEzs+u2o1wOuUkaz+PX2OfOdwKyqAuLFQ2jVstOFGyajsLPh5WJV/
N7eLyTlOzfVPnTQhJEA9HBe8YwocS35V8qVGYoO1W9C+ofSlj3qbQPGieX+JMwWK
iJMgGCwelvYv6zFxJhIGbBKMiApy5+uCeLBRCyjC2jCAdPJ3Zglq4WYcfocqX+EV
bPSId5yESJFvhZU3dxtnK/isPpjIV8vhukBJ7Q+dewTFVaxfE0QrTV4RCx4j7ZZY
COdiQ7rpGhvKxtNydZL3LGAPe6Ti9PXjpVnSvo6IHqTimzeSliWq35GndHxmROLt
2dSO2+gaEDFXvW8H2GxEj7Qbaft3iUpBK+GSbCJf0hGgxgVJRLQiFOyDlG0ViGPx
aj3YQrmxmYBevKxm9VuR1Z9AqlphSeTmpBqiSEWyzqUD6TPZDSfanBYGvmpMJSY0
W25whFy3a32Fjzf0AG5aG/UBbRCcpJ49kcOTxguVTtsIgZ8mZDKg0ymz6Ha6Kgmh
z/EY/HkVK+sCbKRyszVUbYcgUlomzn4dgF9F1s8hbt9UjyQJ02bm7C1p1aehkvRI
DHvsU98nDXOh8FUzrJnqC4frNkWYYUld0QjXvGiS8eRXndgXSyI=
=f2Bs
-----END PGP SIGNATURE-----

--Apple-Mail=_713A9422-50CF-4793-BBFA-A646EEB0262C--
