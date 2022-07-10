Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EC156CE7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Jul 2022 12:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiGJKCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jul 2022 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJKCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jul 2022 06:02:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29373644C;
        Sun, 10 Jul 2022 03:02:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l23so4359096ejr.5;
        Sun, 10 Jul 2022 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=swFPCXufrNxRRVtb689Z8yc0A8TSAEZQ8ASdk/OWEgA=;
        b=j7lBMMrjS36jBxQ9GzGFdYg+Botc5Kg9/GlouVmdtXRY53Z491omx3jCgnNlq3IzZe
         0pgBB14FOlTpnXQDgpEKz3sYn07QKDuZBjaBbWqGLy+4g7Jlj2YYjFcY6wTeHZ2cQIYc
         JRZXagUOq0myqL+qtLwqNMV3sEOvAxWESmiPQ0ER/XzVf5J3woL4UbsEf+UjnzE5Pxum
         SKZwGSX4KHwGngRTCNJ6BdbpgmPN3h2JmKaWpdql+XMCU7LJMX4vh4Te/Ru7D4RYGIxc
         46W2Z42pCQMMspFECwtsm7a8Zz17bYqJdHXB1RRmVbHyEVx241QDd9YBQPif31iVUdZz
         p4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=swFPCXufrNxRRVtb689Z8yc0A8TSAEZQ8ASdk/OWEgA=;
        b=585bVkuOtb61sNdAD1wXCqxHykxkCskJc+ioOM/I/OYKo63fuzYInFsII52aJ3Do54
         I09BR/QPYLAgnXUqZFPMFmZ5dMY8kpTDQw5B3e0lfW5YIs7gBjSaL67QsAefPbsJL3mm
         GE9HfceO8ge2LLdZrMsSJTSkC3e8REuJcbrMdfhvFu5YwpkGxL5X1wFC7/o7uMLsb1To
         efPw6EEreldcBbjvlvessNC608eVKdPr2Loy883z3Xv5eNtEnQURwVoFQajQZRySfExB
         r4Uy+n0IF93xo8Nao12i3u7rDxkeApUWhW8/yQX1YCS4VPMTlyomd1DX6FqKTZwz4hCV
         aC7A==
X-Gm-Message-State: AJIora8W/VVTrAf2RvQqwv/TNn1L5Pb8oZ/9jPJXkCfN51EYJz+KAdCu
        QrJWRm1Uncu6AxTOXLEN1vA=
X-Google-Smtp-Source: AGRyM1spHiiIlC05ygs9jn5HBKBf78FmjeoWRrBODOAvoSoVXI8CtVqfCv48XyuKC+e9izG3qUk+wg==
X-Received: by 2002:a17:907:7349:b0:72b:4d9f:1418 with SMTP id dq9-20020a170907734900b0072b4d9f1418mr1270450ejc.304.1657447350661;
        Sun, 10 Jul 2022 03:02:30 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906318f00b0072b2ffc662esm1436875ejy.156.2022.07.10.03.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 03:02:30 -0700 (PDT)
Date:   Sun, 10 Jul 2022 12:02:28 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH 1/2] landlock: Support truncate(2).
Message-ID: <YsqjtDO6m4OakGSi@nuc>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <20220707200612.132705-2-gnoack3000@gmail.com>
 <78bf2921-388b-df21-303c-c7d1eaa5b681@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78bf2921-388b-df21-303c-c7d1eaa5b681@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 08, 2022 at 01:17:32PM +0200, Mickaël Salaün wrote:
> No final dot for a subject please.

Done. Will be fixed in the next version.

>
> On 07/07/2022 22:06, Günther Noack wrote:
> > Add support for restricting the use of the truncate(2) and
> > ftruncate(2) family of syscalls with Landlock.
> >
> > This change also updates the Landlock ABI version and updates the
> > existing Landlock tests to match the new ABI version.
> >
> > Technically, unprivileged processes can already restrict the use of
> > truncate(2) with seccomp-bpf.
> >
> > Using Landlock instead of seccomp-bpf has the folowwing advantages:
>
> typo: following

Done. Will be fixed in the next version.

>
> >
> > - it doesn't require the use of BPF (conceptually simpler)
> >
> > - callers don't need to keep track of lists of syscall numbers for
> >    different architectures and kernel versions
> >
> > - the restriction policy can be configured per file hierarchy.
> >
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   include/uapi/linux/landlock.h                | 2 ++
> >   security/landlock/fs.c                       | 9 ++++++++-
> >   security/landlock/limits.h                   | 2 +-
> >   security/landlock/syscalls.c                 | 2 +-
> >   tools/testing/selftests/landlock/base_test.c | 2 +-
> >   tools/testing/selftests/landlock/fs_test.c   | 7 ++++---
> >   6 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 23df4e0e8ace..2351050d4773 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -134,6 +134,7 @@ struct landlock_path_beneath_attr {
> >    *   directory) parent.  Otherwise, such actions are denied with errno set to
> >    *   EACCES.  The EACCES errno prevails over EXDEV to let user space
> >    *   efficiently deal with an unrecoverable error.
> > + * - %LANDLOCK_ACCESS_FS_TRUNCATE%: Truncate a file.
>
> We need to specify the ABI version starting to support this right.

Done. Will be fixed in the next version.

>
> >    *
> >    * .. warning::
>
> You need to remove truncate(2) from this warning block.

Done. Will be fixed in the next version.

>
> >    *
> > @@ -160,6 +161,7 @@ struct landlock_path_beneath_attr {
> >   #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
> >   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
> >   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> > +#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> >   /* clang-format on */
> >   #endif /* _UAPI_LINUX_LANDLOCK_H */
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index ec5a6247cd3e..c57f581a9cd5 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -146,7 +146,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> >   #define ACCESS_FILE ( \
> >   	LANDLOCK_ACCESS_FS_EXECUTE | \
> >   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > -	LANDLOCK_ACCESS_FS_READ_FILE)
> > +	LANDLOCK_ACCESS_FS_READ_FILE | \
> > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> >   /* clang-format on */
> >   /*
> > @@ -1140,6 +1141,11 @@ static int hook_path_rmdir(const struct path *const dir,
> >   	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
> >   }
> > +static int hook_path_truncate(const struct path *const path)
> > +{
> > +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> > +}
> > +
> >   /* File hooks */
> >   static inline access_mask_t get_file_access(const struct file *const file)
> > @@ -1192,6 +1198,7 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> >   	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
> >   	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
> >   	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> > +	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> >   	LSM_HOOK_INIT(file_open, hook_file_open),
> >   };
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index b54184ab9439..82288f0e9e5e 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -18,7 +18,7 @@
> >   #define LANDLOCK_MAX_NUM_LAYERS		16
> >   #define LANDLOCK_MAX_NUM_RULES		U32_MAX
> > -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_REFER
> > +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> >   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
> >   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index 735a0865ea11..f4d6fc7ed17f 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
> >   	.write = fop_dummy_write,
> >   };
> > -#define LANDLOCK_ABI_VERSION 2
> > +#define LANDLOCK_ABI_VERSION 3
> >   /**
> >    * sys_landlock_create_ruleset - Create a new ruleset
> > diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> > index da9290817866..72cdae277b02 100644
> > --- a/tools/testing/selftests/landlock/base_test.c
> > +++ b/tools/testing/selftests/landlock/base_test.c
> > @@ -75,7 +75,7 @@ TEST(abi_version)
> >   	const struct landlock_ruleset_attr ruleset_attr = {
> >   		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> >   	};
> > -	ASSERT_EQ(2, landlock_create_ruleset(NULL, 0,
> > +	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
> >   					     LANDLOCK_CREATE_RULESET_VERSION));
> >   	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index 21a2ce8fa739..cb77eaa01c91 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -399,9 +399,10 @@ TEST_F_FORK(layout1, inval)
> >   #define ACCESS_FILE ( \
> >   	LANDLOCK_ACCESS_FS_EXECUTE | \
> >   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > -	LANDLOCK_ACCESS_FS_READ_FILE)
> > +	LANDLOCK_ACCESS_FS_READ_FILE | \
> > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> > -#define ACCESS_LAST LANDLOCK_ACCESS_FS_REFER
> > +#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
> >   #define ACCESS_ALL ( \
> >   	ACCESS_FILE | \
> > @@ -415,7 +416,7 @@ TEST_F_FORK(layout1, inval)
> >   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
> >   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
> >   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> > -	ACCESS_LAST)
> > +	LANDLOCK_ACCESS_FS_REFER)
>
> I created ACCESS_LAST to store the last access right while avoiding to copy
> it in ACCESS_FILE or ACCESS_ALL, and then avoid forgetting about new access
> right, but I now think it is not worth it and I prefer your approach which
> will be easier to maintain.

OK, thanks.

>
> >   /* clang-format on */

--
