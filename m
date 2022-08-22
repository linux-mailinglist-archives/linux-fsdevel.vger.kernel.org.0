Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2870959C100
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 15:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiHVNwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiHVNwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:52:07 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596B132BA3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 06:52:03 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11c5505dba2so12901704fac.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m73J0a+SpVfFWhhFyKyas6A9QyGH23phPhrWwSIkcsg=;
        b=0S3Vde4uVPpqrwPrSn1lB/BfHqxw7g0fVMQHKT61OyhdTOtVhgnuM8VKLapQrHBQ8X
         suJr5xe8z6Ty7J9guCGdAbnnjuvcV6ZhU0CHTn61GfDgO9yA7ZtWzN4BcMCzHmvYPPud
         ITtvX3vD7dU5cG6HOJZy6M/DVFJJhxNH42et5otOd1jDNZqHxLI0pUb/zQ2U7sB2lCtm
         M53lNHSrkSUJQw+w8Ag58hDIep3lLqAu1+0RnN7xgnarAtGFkwG+Hc4ARIhC1yD/Qfq9
         44u4uP2snLqRLedeJ3yaaWOnq8IdsqZsBJwHTaCUmqBXyt3NVeWSHUU3gptroo3ev4LS
         ZOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m73J0a+SpVfFWhhFyKyas6A9QyGH23phPhrWwSIkcsg=;
        b=ruFvBwi5xcIeqU/TtjlgNU5Ph8bQkRxSzurROkTmA7pyCmbto1+hdBbIVqxQS1msLq
         yJuWJSSXPLmW3h2LbFQhd4hDRbb6BcvfsRcqbNK+8IL2Ve1eoCMGbnpBKzyP+79wf4D6
         3vb0GCeorbtD40wdDZQjB1PBllNgyYK2FDNAb90hY1829BZZ1gPFMavzriym7QM+koJ6
         6ftAUt+VQTmQpAROQFXeveD91/aFWzsq+40IiKZgmKqUqPv/jMFqRUcNHG1pdhG7oae9
         VC5zPMfUt/w2QdoOnC1CUj8UYULXRjs7X7s32jOJjEmiwCjj1RM8s3zE9oREOcnwIy4J
         GhPA==
X-Gm-Message-State: ACgBeo2cxENNWHs3UatSJ/z0grm0j+Cwj8IuXSo4UQvZxybTb1JeuEtX
        YREUBGGfOtUTdVUfHMCxh/MqvtHgG0JOydfn44TZ
X-Google-Smtp-Source: AA6agR6MT2srz07bE02RPC0qNPY68niPs6ITLMH7RnLkt58V+xS6X/ZpYBYD8DSuWO6HkBAn6REe/BSbtpuhEQkhjOs=
X-Received: by 2002:a05:6870:7092:b0:11d:83fe:9193 with SMTP id
 v18-20020a056870709200b0011d83fe9193mr770914oae.41.1661176322392; Mon, 22 Aug
 2022 06:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <YwEjnoTgi7K6iijN@ZenIV> <YwEjy6vaFHEVPwlz@ZenIV>
In-Reply-To: <YwEjy6vaFHEVPwlz@ZenIV>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 09:51:51 -0400
Message-ID: <CAHC9VhQXbhdywdxrOmQ4J70zZo2EZBcrPsmJC0J7WWyb5Bskdg@mail.gmail.com>
Subject: Re: Subject: [PATCH 01/11] ->getprocattr(): attribute name is const
 char *, TYVM...
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 20, 2022 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> cast of ->d_name.name to char * is completely wrong - nothing is
> allowed to modify its contents.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/proc/base.c                | 2 +-
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/apparmor/lsm.c       | 2 +-
>  security/security.c           | 4 ++--
>  security/selinux/hooks.c      | 2 +-
>  security/smack/smack_lsm.c    | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)

Thanks Al.  Based on your other email it sounds like you are going to
send these up to Linus, which is fine by me, but if that changes let
me know and I'll make sure this patch gets sent up.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
