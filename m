Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17B5F3955
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 00:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJCWvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 18:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJCWvb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:51:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528B63FA;
        Mon,  3 Oct 2022 15:51:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b4so11792897wrs.1;
        Mon, 03 Oct 2022 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=An8VVE7cGapQqhJ0PYYIqb/+22O/OEiMpuJHfspPYec=;
        b=e6t1j9JdoDt560d/ckNFkUL3Cib+c0J2aoZeaADhl9sbp8aFi+n3AOTK80bmnHOBgA
         3H0ZUtvZ3c3sIEYcMF4LwiVUJyERaHG4aaL1Xfgxg4K0Wdu8NuxxORvGlQ8Gau6feze2
         W1gJALd0S6lR3QENOPZJlfD+jH04LRYbrtE+laDrcEshwGKtmWrk5ejf1zCYZGrKwo0f
         cojeGRItIrsKEELt7FKA/40YrFCRt1wxoK7CrwcLn+nZmA/+U5TqWNpvRRwe+wy19kyK
         JuWFKvaP+2WNAiMUo6Ym9vwAwXd1wTwsurZiOZaj/0idXR2CDGk2N9b3kDf8XHqZCs21
         CcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=An8VVE7cGapQqhJ0PYYIqb/+22O/OEiMpuJHfspPYec=;
        b=lnuZBVcHrbuGQP3okVWa5KdhSb0omEfjPMRxHt/dxTVfX7SH17nEPKEsauChdTIFi3
         Cpnv4u7ActW3FOjy30vpJWitufsgUIvtMX3iikVCEIFl5asRnyboZVdI+Dus7YnOTAaP
         PWqyusi2YK9A8hyVAi25hCjmBvFMIUKpP2YU/edFnd7we++756+na58/AjIf6pIQWaPI
         arZVu58FtdeBPRFm7r4UHSHmHDNSmnh1dHGvdj935xKjcxjLrnK0Wv5FbFbv9fUyVrZu
         CPt24U9JoRdFbGQ9Ttu8YR350YhLeLtzRv2W1VSlAz1tu+T1iGskcNhDTm82zqVA8pMU
         GOkg==
X-Gm-Message-State: ACrzQf175gPq6MkxAHjt3haM1NS5lA+ryqebTlc66tUP9eWxWdbtFBaL
        e8JFiu/HDxFrg5tv4atI5OCM5PQP1lzbpw==
X-Google-Smtp-Source: AMsMyM4J/7taWxqUMoJleAXnc7eD6eEXq6jpT9Pj51Tjkaqvf9x7ljlULZtXEhkjOYheB+/+vDavzw==
X-Received: by 2002:adf:a555:0:b0:22c:dd2a:41b3 with SMTP id j21-20020adfa555000000b0022cdd2a41b3mr11853797wrb.366.1664837488509;
        Mon, 03 Oct 2022 15:51:28 -0700 (PDT)
Received: from [192.168.42.102] (mo-217-129-3-75.netvisao.pt. [217.129.3.75])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c2c4200b003b3365b38f9sm12768414wmg.10.2022.10.03.15.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 15:51:28 -0700 (PDT)
Message-ID: <3be00e03-2aa9-0b7c-40e4-e3dfecb05ad5@gmail.com>
Date:   Mon, 3 Oct 2022 23:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: pt-PT
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
 <1194d7b9-658f-b724-93d4-2f2b02b569ca@paragon-software.com>
From:   Daniel Pinto <danielpinto52@gmail.com>
Subject: Re: [PATCH 2/3] fs/ntfs3: Add hidedotfiles option
In-Reply-To: <1194d7b9-658f-b724-93d4-2f2b02b569ca@paragon-software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Às 17:40 de 12/09/22, Konstantin Komarov escreveu:
> With this option all files with filename[0] == '.'
> will have FILE_ATTRIBUTE_HIDDEN attribute.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/inode.c   | 4 ++++
>  fs/ntfs3/ntfs_fs.h | 1 +
>  fs/ntfs3/super.c   | 5 +++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 51363d4e8636..40b8565815a2 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1257,6 +1257,10 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>          fa = FILE_ATTRIBUTE_ARCHIVE;
>      }
>  
> +    /* If option "hidedotfiles" then set hidden attribute for dot files. */
> +    if (sbi->options->hide_dot_files && name->name[0] == '.')
> +        fa |= FILE_ATTRIBUTE_HIDDEN;
> +
>      if (!(mode & 0222))
>          fa |= FILE_ATTRIBUTE_READONLY;
>  
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 2c791222c4e2..cd680ada50ab 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -97,6 +97,7 @@ struct ntfs_mount_options {
>      unsigned sparse : 1; /* Create sparse files. */
>      unsigned showmeta : 1; /* Show meta files. */
>      unsigned nohidden : 1; /* Do not show hidden files. */
> +    unsigned hide_dot_files : 1; /* Set hidden flag on dot files. */
>      unsigned force : 1; /* RW mount dirty volume. */
>      unsigned noacsrules : 1; /* Exclude acs rules. */
>      unsigned prealloc : 1; /* Preallocate space when file is growing. */
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 86ff55133faf..067a0e9cf590 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -247,6 +247,7 @@ enum Opt {
>      Opt_force,
>      Opt_sparse,
>      Opt_nohidden,
> +    Opt_hide_dot_files,
>      Opt_showmeta,
>      Opt_acl,
>      Opt_iocharset,
> @@ -266,6 +267,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
>      fsparam_flag_no("force",        Opt_force),
>      fsparam_flag_no("sparse",        Opt_sparse),
>      fsparam_flag_no("hidden",        Opt_nohidden),
> +    fsparam_flag_no("hidedotfiles",        Opt_hide_dot_files),
>      fsparam_flag_no("acl",            Opt_acl),
>      fsparam_flag_no("showmeta",        Opt_showmeta),
>      fsparam_flag_no("prealloc",        Opt_prealloc),
> @@ -357,6 +359,9 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
>      case Opt_nohidden:
>          opts->nohidden = result.negated ? 1 : 0;
>          break;
> +    case Opt_hide_dot_files:
> +        opts->hide_dot_files = result.negated ? 1 : 0;

I believe the 0 and 1 should be switched here. With the code as it is, the behaviour is
the reverse of what is expected: the hidedotfiles mount option disables setting the hidden
attribute and the nohidedotfiles enables it.

> +        break;
>      case Opt_acl:
>          if (!result.negated)
>  #ifdef CONFIG_NTFS3_FS_POSIX_ACL

Hello,

I have found a bug in your patch. I explained it above. Also, the patch will only set the 
hidden attribute when a new file or directory is created. It will not set it (or unset it)
when files or directories are moved or renamed.

Best regards,
Daniel Pinto
