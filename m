Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B297331C4B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 01:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhBPAuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 19:50:54 -0500
Received: from sonic315-55.consmr.mail.gq1.yahoo.com ([98.137.65.31]:42751
        "EHLO sonic315-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhBPAuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 19:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1613436578; bh=uCn/Bflq9/wBUpEgI+BGaqJEFBlq0OwkbVwQBJDS7V0=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject:Reply-To; b=WKpmldmlioOSiKnU0OXf8UaMGc0ozpBDy4JALwRX8uNNa8hX/fEwuB6Br5iguLcxaFSj59Wp9oRj2kYQPEp8Y9CpY9au9vV8dqOwkIL9pcE/DRdvPVtfC4Ad5xWiB66cW3UVoaIFBFT9kiAftKvdiuBdhZZWL2/kLt/0lOgkFDl2VamAZB+9E1C2uxJWq2OQhABkjLIeY8imh4c+3RgmPZ0D6UbJdyXR5v2KmV+wyveWIe00KtzxYozLGT+oxz5igU2BERxUV9JkOFdzjX43XiHQzxuDgP0rCukFhlKn9wUCy9/m4h//ZBadgOiLfiRoEUo64ef5ero0T2aAHb9p0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1613436578; bh=4K43OsaN+c3jkspguRDAWVkUOYXOkclZJICSojcXm7Z=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=bQh7o/gD5oJjp79PChp3fGKwX8uWFuGECDmxnzYn6f1lsqVVsfmxEi9iKaS3zQShpqz1E+seIDxyQsXVuTHtZ0YRM8WGMK3GDd7uE5VkA2KVZR/T+d4GazXYrRbIMXkFPFRC00GIdNR581UpJqCLsHHe3hPdFE9ZAXPJ667Cy6tlsmAOSto303CEdNoJaf4YNstPeCJOSelEyVAgOsDQrg/1k1Trobcq8TMzp5zkbCjeeY4+Ix6Op+YntkCzMrdCcRk+mXmJ3Xz2Io0cOwm2aw1PCR6ngoJlqCfuCt79RMu9sM9tdd5I5sot+Ls64O1UILGLVxl2Jiy9udrX1FZ9fw==
X-YMail-OSG: RhkyYoIVM1lvMN0kXt5R0eceLxBg2F24d8srvRU.xEsBPvY2KtCSx._ni8SbuAo
 F7Q0qayE.k61JySmeiRO2_UvCN7qstvZTLkuxxQ7nD55oR0j7WdkBPDYQlhWLxb3swSBr8xBnyjJ
 KtuYxhkjltN4EUSL1EOZ8VRt4bmF4zsPZ893YW299ocHMx3X2LGhlPldVud09y5xZdNY9ntVeY0r
 JLZqjEjrtaZgbbCdyHMigiYTGzxDpdr8ZrY5RCmPIECm5TWfIpA9PKEMgUJ3IykirWhCjf04a0Sz
 Hb45GLJR9VShaq27L88B83MvrBXh2Nv5fWyL__de2bzdlcMRAZamx.GE5Mtn0StEDKAInIRIpaKn
 n6W8EAKXunShmv0y0A3YWe29H0okVIXeQmC6HWJ7gG039n52ufXnTTUgxVS4gyRS_b_ddPCb8Cvm
 E4kOmu2Nn.ETHhyXwkm40IDZfUSxSNNtYrK6W2r5UOJr1mq6G0wy4z423CbHVuGXwSKAFaDWuY4E
 KgmqqQFDXwRhSJeRPYp8AyYNQG9bUkis1zj6uIz9Dfe9fRoazEsU0TDVRX.gATuEejrM_v3Fv3Jd
 52zpLI2oj.IDOymMP3b4pcl.TD7a5N4oy6gWMGIWI3VYcyUx1iQbPN.sUfPJXFuHL941KNaUqD9q
 FHD_yFGOpzVZfiNgVqM_9HdZYAOBNqRVpd9OD16GyIPxkPDBCeRFQ2SMjj3cINrqfjzp59k1g8hS
 QUFvo2_pFNAuWwvrPHb9p3QCsXbbReM3QoZ47L1I74BTuNSb_CEk_iLQkoxDISlMKW80Qc.a3ubI
 afBm_UaqtV6pNtwq43RlcoQoG020bKexH12.oqv8aHtz.Bmg16UDHgYh7R71S8IHSbwtnpzQtO6A
 W_58jF3upUZ3o1dqwVbPABzI1r6mwU6.2ewBS2cZP_dtLHxSvELBOd7h7ipoiowV.e8VtLOHwfTB
 B6VK90iXElBKh4GfP6cANxYv.RyAhwrlg7mMjUDdvYS4g6rBtocXEB7CdKBv0hWLvy9SAUVUjo7E
 hwxYJuJUfvHl8JlK9eK5XM7RuLcU5gqx0UC12gsweTF0wTIMK6Q_9UhL8dKLRIWDnaad3o90uxQu
 lfL4kusJ3s_s7F8yU.TM7LhixD.bc3mmw9Cwyt.ztX1jBWrtKLQz6Ld_SgvOfKnj.L28Ob4oFsVY
 O6T.jLfsqlLogw4OFo5lfrnlyH9.Tkgl8wBurqbxswsyqTQoqKnIWXQQzBQu0xaWlJItkrvQ09HB
 ISmz4WbV7D7YJxdCnY7XmQWVVvslMsnseoD1OX.RbPmurVZbcQBe9pnAk4ovLufyeDTYUJMU0lwO
 yoNYJrQOoghU3MBRAT7c3l0ujpxH0Lgm0anf3L6Nuy0BbQfCtkO8YPQzrTImLAktcx985xXROVUY
 biVu9uf3Cxj0vVhRWGOqSYYn6d11S_aKnq7YoH0nFXU_nrX86lyxxMpVl7._XEa24ZU0ADa26UIG
 ct922vsujxw3J7I1w9omCiOWgsw9kYlbbaR0fS9nNHKiz9_h4q7HeHv_RGi0veD0cVDFGpCh6Gct
 eYFLvY7hlKdZU88f..UhqaIhIPRpRnkBbM8E5m1gf6dcTu12a7i1WDVmOXV.c.jajRC8Ora7rLVo
 mTp6Ff_sbjBwHUoqKFUPWVl5TqvMG4o3ScqtzjSL2Odsp5VBDhtgXacCg6YHgtLSlT3y2WOtH24a
 RPnrTpZuaK6td53Fwp5P0E0jRBvpq5WeqBJrYRn3motEjLsydEdSVlzri5bci6nZQYKsG9HB1Azc
 lZ2BLK_TVjsD1t0MwPgNgWNAqvyjG2ljaxZJOlx4HAgGr0NIG.gptSr.G6MOxXf061wSHAVKYjqJ
 GAL3AH4HEglbQhfmoROnMNzCKv6LCnYlNfcJAtbYdzd0mEkbfx_tve5roHwi5BPuqyRllas_.4nl
 bd0eKXT_6ucc2fKoQWEmZgPmbCCXRmoHRtJPElAYR14zvADpnQ_svPnUPmxQ.hRB0Zsh1iVz72Dq
 WN_I29z6sKsaIN4p3qJuV4EdKROKHIu_TNYMNYdbZI7PiHQpJhX.fa_LOanRvCrBWfvRAjjQwwlr
 9T4qr1EhDbLchB_isasOE_.TdZvJ.MaNWHRANRdbChF.o3vXW_9Gto54TDiirjZUVjLlAxur6BNT
 tt1pmJu5dT0erJZWEHH.0ASTzw8YsnPAyzpxy9uv06DpkSVEA6ZDDIR2XJYRsUQFQ.9Xm50abUqL
 qtocHi3.hc5Hu15Hbi3FjrWGdtxfYnVRKR0amvXTKRZBgbwUv7BRfI6govrzDyaHDuTjUE_AopOp
 _YhaHdgE2DMo2A1m2BPLA1Awk7lsv8bwTIInN8NxDMke10h1QiYJ_.Tr7Bf8LnCOwb2EWibWEuAg
 _gs2BXqDNWfCGesZa4AySiWa7JcgO3_H_BXUrpMgbNXiG2kDtjMZdrFyYhNzkHgEdePRdgWcWWNZ
 iCYcjgcVxp7QpHVQoFTc5jtQVYPGT2QVF5Y0Vxi_H0yHvxbKN5zN2DCEby44X_HtSPij.9cK1k7G
 JFSWv8KKLMLDr1Bz.KFAK189K3JNIpP0xhYVp09E814nTiiHd12KUtnx9TbXxAKX4VOTrWDAMU1Y
 18.8zNR.zzznq.dPX9N4i7BgZiod3HO8h.jQZBQWsINPIc4ucWpwN7ilWm.ufWvwqKFvlMAW7OZ6
 ZbP54ULOKeYs-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 16 Feb 2021 00:49:38 +0000
Received: by smtp408.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a743c5bf659a941befe506b5142ddb40;
          Tue, 16 Feb 2021 00:49:34 +0000 (UTC)
Date:   Mon, 15 Feb 2021 19:49:31 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] proc_sysctl: clamp sizes using table->maxlen
To:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>, Andrey Ignatov <rdna@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org
References: <20210215145305.283064-1-alex_y_xu.ref@yahoo.ca>
        <20210215145305.283064-1-alex_y_xu@yahoo.ca>
In-Reply-To: <20210215145305.283064-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Message-Id: <1613436483.9rqrq5iswg.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Alex Xu (Hello71)'s message of February 15, 2021 9:53 am:
> This issue was discussed at [0] and following, and the solution was to
> clamp the size at KMALLOC_MAX_LEN. However, KMALLOC_MAX_LEN is a maximum
> allocation, and may be difficult to allocate in low memory conditions.
>=20
> Since maxlen is already exposed, we can allocate approximately the right
> amount directly, fixing up those drivers which set a bogus maxlen. These
> drivers were located based on those which had copy_x_user replaced in
> 32927393dc1c, on the basis that other drivers either use builtin proc_*
> handlers, or do not access the data pointer. The latter is OK because
> maxlen only needs to be an upper limit.
>=20
> [0] https://lore.kernel.org/lkml/1fc7ce08-26a7-59ff-e580-4e6c22554752@ora=
cle.com/
>=20
> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>

Yeah, no, this doesn't work. A bunch of functions call proc_* but don't=20
set maxlen, and it's annoying to check this statically. Also causes=20
weird failures elsewhere. May need to think of a better solution here=20
(kvzalloc?).
