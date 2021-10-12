Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9215242AD02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 21:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhJLTLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 15:11:40 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:41745
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231886AbhJLTLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634065777; bh=PPc0yEkHBh7vGwpDaIbMgP8xtJQEaRw6slb/cxioqtY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=lHjP9tlXMoK13UVN5YvDqc65wa/MFABWtbD9r0kFr/H+Z0azdai16/tUzHjnVInEnzBaLLxMYN7gSF2Y6F8yTS8zIObF19xrUqxZXtfkay7NIw/Sj78ae1K3A7JD8uN0NP6Xz1YCgvWIBjU4Q+cS/C9kv5lpX0p5kokbSyr3IsncnY4k0T3R33ShhS5KG+XgCoo4/QuTtRs305tl1Tlk3ftvHEFAvaoXxsZ1uzA9wlYFiHa+DzQO/rzxVQZBMzEmvyP5cX7KaGXaCxbVA0/wARqWuH1E5RmNnfa/K22G9fOKx5qOhu5bQGqUNaGGzkK9zUDT6XuJqiwIAPM4y06+Bw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634065777; bh=9G+zhhsRP+n7cJO3iKxP6CE+G3F3lcWRB0v3pDj82sJ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=XPZ6C4/uVihfrLKDz28Myk05s3TeBYdEanwt5aDatKWvq49N68I5fu2sP/ZvBlM/IXtuwPmhMhsoVCqpJb9ZLg4yCB4azkgc3ywJwKgAndkPc7sEmghgM1UU+xdZEBCK3qyFcD1rVzt7lTJIV4dO/od0xrnQrJ42QIS4fRlTobi0J6Fzrx6W2xMsgPS0EQhNRej1u/CqF8YbjgZHPEdtVSVi7lfOqu2rtXpWRR959TljDG8gstCciw64ocyxLIv+SoDiTWjERR8xKLvrwHrTIL05vNe9FKAdoQW63x1J+xHDhxbbJInk9n+air0nkrKrlweygxBVRNWk91CjzYIKOA==
X-YMail-OSG: g91y4l0VM1nRUcvf2ULwXbr_HDTvirSBldveXo99jypulElJlA9Ei_DXVhqLorW
 hr6QUAzbkoEM9BTvwpjNjRwVgY6CiukXUfDSXsqtriHZPVipIVrZaonewurtpxTSye9SCJUlkD1k
 O9TaGmUdXJNnjA4EgswizfLvQxtM261Q0zTsxZsGQH1pRsTIeoRiedB4gLx_Rj2b295.4c7Q.2YC
 z2fqDT_pcFOMTRX3bCwqRL2N0WILBXGx9dH4fuWuMKQH5mehKY0Es2kSfK3kQGer5P1EyFykKPK9
 k5If3vUo1AkD73Y0xqK2eE0XyQyAPVa1z3562t6DCSNeqB8EojXm52dYFYv0fFK1hykcaPNcHPHu
 vMyyfdg0rBNmcbUuxzH3y2Foq_W0N22aZO3WWpe4U6b8eBBQYjxddkR9KB2zIOvpIgz8BwlHUsw4
 n5ZR2jceJmbFDEk1bX4xLOT_K0CPpOoirjnn485IV8h9Zp5Epkur3GYV4catuFRQZJw5wEi.X0SD
 CLTm57qv7jdz7klSAz84DuyNkl2_704OaljIH98ZIbBHZnQldelJXfAMeyJ4Qdxyvkn0ChDPXiMx
 B.tcsl5n7RomcQKPbvEhpudoh9iUY170kbGnVul8EwJ.rmzsdomXRzq87o_.U9W.vTmKIW6Dmv3p
 MbV.pD3ORwdhZWqcvY4DR0u93ZjEU05aqn6fEuS81bvIN6rFRsu8S6UFUtOFX0XT4awnGdvUcsr2
 PXHmE6FNiXNFz5UmxFlTnBVLIZiTC.TxEv4MU1nc6fs._OtlWW5O4b9LgV69yFCYIBLyEPLV4Sz.
 lLP_LvvnkofDw2cAaz96BfeoKYWQKsCyLnxeMS_k3YPjxP2Qn9LQrYdBz1VuqR5mVcf_SSSGHFlc
 kyLz_W63XZeazDhZLowtdIdA.2jGlsN_P4hxTKKV6_shw77OQoJ_sr1Kr7OIXtPIreMp1MdDtVbj
 KXpOWybiIFhxdejy0XuuArnE8NvIlvzOgpqTjdwZ2GX3Nuwr3T2URv7q6psOaPJk.DJJXWF5dx3n
 wPk33_n7xB29bRqS8AOuiFLgzw6QBBAwh7.GwFfK4hjBogzGqojOLRJt63Qc6ZyQP4EoxUZ0MQXl
 XwtQOiz_JU3QIPIfFqPEZjdT6L7oEbT92zxhHzIV9s8tshYcxqVMW4iemOvnz6SIjaNdiLt_Z_nx
 CtDdd_vVHEU0xT.x6Z0WiJ8ns1azRdjAnxMhjZ009G7gSmrzm1AliBBtF2XbE_cbEuuSyUxX.inR
 myQ5zUWy7Oql1jS0pzXfUVqT17NUAKuuNOwj.al0GGyBFEDYy7lRBF0i8qnR5BnBKHP_glIZwbVB
 HHmrlauU_ValEgCkms516yqjMAn3irGRqqTBcejJSfJ5HvPwv_1uE1qeKT71LNYzJm8KRUykvp6v
 _nuNhNBRBKh0NTtyIEZl2eYOyIfg0M1tTWPiZvra4jF3P5S7w9pENDRStvpyR8RMFNkrgACkoNmw
 VMiX2VjJDB07eVSzPhTZjghIKNshIUHpUiKHERJFpn5DHgDhB7OMKuYy91pM6NghQdMKhZH_40YA
 cPtf5WhUFmcqyNdLtDW4Gq.VGLTEorMqyls19tWXYyHZF2HvbR9lloEnwrCkFLJ_os4bkaT3goTF
 jvyMoRUhZ9UzIidXJOIYZ_buhHhk5bkUo5e.DOrwkEk69Cb.fzBqWfJP39iOs6pjfqfmClQ3Cn0w
 8HRxtLsxV5MAQoWtFk_ZHwjLArw6ETdA5qoBE5MnycWtjRLs.tXpR9LrJt1c1gyZ7v6NNNuzsrUq
 x0FUyNGiyWs6rn6PHCLcxrNiSXFrXuJXPJOZu7i6zastTDD.Tr9oBF1Zno_0enV1f1wjFzqMTlz7
 845bJhQm3JQu.rbxRd50P4FCmC6f4.9J8c3ZLkGPhzB6KC.Nj2uiGpx3l1j5tMo0J6hS4597qKmy
 m2kbjj_KkEO5nshKZILRClUfFO4_wtNUE6Ew1Ag8C535qVsij5LasJN8eJvB4H2kElceFLRoIbJL
 YyxYp3vnN6ND8QyOp6OSCS2.iEH1uoZFhTTq9WMKxbajsIE_nNSaB8H3fdMcHQn36JIEeB8iHKpb
 seNaodmwcLESZM3C6NOUKmNferL5PKttiUkwoC.PtKxXhrHyRDiT2oTFfluDAuQvNydZMieU1D79
 prJ2_hpViGo48vTHZI7joRPFp_fjasimGodizZtHiCtlf70Fyui9.5DtdJlEhwRpNMbX.fAia4nX
 jiMZqT6PtasSEwBV0fU9Dvmx71k6PiOU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Oct 2021 19:09:37 +0000
Received: by kubenode524.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b7c3aae7b555a6527db6974de8268a0b;
          Tue, 12 Oct 2021 19:09:35 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] fuse: Add a flag FUSE_SECURITY_CTX
To:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        miklos@szeredi.hu
Cc:     virtio-fs@redhat.com, chirantan@chromium.org,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        omosnace@redhat.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20211012180624.447474-1-vgoyal@redhat.com>
 <20211012180624.447474-2-vgoyal@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2a7afeee-1f34-fb1c-13b1-0af1dcd95b68@schaufler-ca.com>
Date:   Tue, 12 Oct 2021 12:09:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012180624.447474-2-vgoyal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/2021 11:06 AM, Vivek Goyal wrote:
> Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> fuse_init_out struct.  When this flag is set the kernel will append the
> security context for a newly created inode to the request (create,
> mkdir, mknod, and symlink).  The server is responsible for ensuring that
> the inode appears atomically (preferrably) with the requested security context.
>
> For example, if the server is backed by a "real" linux file system then
> it can write the security context value to
> /proc/thread-self/attr/fscreate before making the syscall to create the
> inode.

his only works for SELinux, as I've mentioned before. Perhaps:

If the server is using SELinux and backed by a "real" linux file system
that supports extended attributes it can write the security context value
to /proc/thread-self/attr/fscreate before making the syscall to create
the inode.

>
> Vivek:
> This patch is slightly modified version of patch from
> Chirantan Ekbote <chirantan@chromium.org>. I made changes so that this
> patch applies to latest kernel.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  include/uapi/linux/fuse.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 36ed092227fa..2fe54c80051a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -184,6 +184,10 @@
>   *
>   *  7.34
>   *  - add FUSE_SYNCFS
> + *
> + *  7.35
> + *  - add FUSE_SECURITY_CTX flag for fuse_init_out
> + *  - add security context to create, mkdir, symlink, and mknod requests
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -219,7 +223,7 @@
>  #define FUSE_KERNEL_VERSION 7
>  
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 34
> +#define FUSE_KERNEL_MINOR_VERSION 35
>  
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -336,6 +340,8 @@ struct fuse_file_lock {
>   *			write/truncate sgid is killed only if file has group
>   *			execute permission. (Same as Linux VFS behavior).
>   * FUSE_SETXATTR_EXT:	Server supports extended struct fuse_setxattr_in
> + * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
> + * 			mknod
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -367,6 +373,7 @@ struct fuse_file_lock {
>  #define FUSE_SUBMOUNTS		(1 << 27)
>  #define FUSE_HANDLE_KILLPRIV_V2	(1 << 28)
>  #define FUSE_SETXATTR_EXT	(1 << 29)
> +#define FUSE_SECURITY_CTX	(1 << 30)
>  
>  /**
>   * CUSE INIT request/reply flags
