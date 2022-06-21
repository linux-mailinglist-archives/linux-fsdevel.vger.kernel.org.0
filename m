Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB4553977
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jun 2022 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiFUSWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiFUSWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:22:34 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209BC22537
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 11:22:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-101b4f9e825so14952156fac.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7Z6JPxeoEfQ+CNB5GhlX5PEYG0nU3hs47jjFuZg2aU=;
        b=NgBGlqB3snahP+Sx9Z9juWLLvCsyFMaWbnANemQKlmvOD94C+vO8jdb1Oit4RhCCTy
         N7qTkohglt4UWoXlOXSzFv+b7oqCYm3xscHg0XcReulz0C/jQWi5BDy8KJqbDirzf9uS
         686Xn2ZHS0Yo8if5XaSiGdbCtmMNwrn9d3s+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7Z6JPxeoEfQ+CNB5GhlX5PEYG0nU3hs47jjFuZg2aU=;
        b=TZ5asPuHZ7P9QcKT8VJLY8oXDliBgjZA3j2+WzL0pxfdJAGKFDzOXSNtRzCpMjbqzF
         AjZvkor8hFQc3jKsso1Bz/fEaLv4KulXlRw+5eD/HC/EE7iwJ/ZAYfVS52lB0METy1on
         DGmnBeF2jbuBZ47auqXY2nNc1jJN5WuSyINsJ9yNhT3TOcQbq/dJ9x4Y5EDhhEIvVOQM
         sgw4NN2vXR9ZQrKpIWOkAxL+hS4yQ3M0eBX82SpR7pCEyf0g1rnY6rvgqfztOhzk4sYd
         jV+uz0jqcz/UzqYG1YnfjAnKwVw0IExZ6LdMw2SEb8OJHBa4kaNzcaf2kN6oodB8JwZI
         7BmA==
X-Gm-Message-State: AJIora/HIz7SGM4AaMgXtXKxuhVy0p47pUl+oSFHt+j7JzxeQqmlxhRS
        aYkTQsePW+/+9I+NJeG8r62XYLpBHnMOUw==
X-Google-Smtp-Source: AGRyM1s5cET4FflE0oKRt67FA1swM6vVDls5jOZpa45yTzO0rWmSOzgWfpjtsRjhZl8BfNkATFLjCA==
X-Received: by 2002:a05:6870:c08b:b0:101:45fd:7245 with SMTP id c11-20020a056870c08b00b0010145fd7245mr17731769oad.296.1655835752394;
        Tue, 21 Jun 2022 11:22:32 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:f75:a0ba:c393:cce5])
        by smtp.gmail.com with ESMTPSA id k2-20020a4adfa2000000b0041ba545a844sm10125256ook.32.2022.06.21.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:22:31 -0700 (PDT)
Date:   Tue, 21 Jun 2022 13:22:30 -0500
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/8] mnt_idmapping: add vfs{g,u}id_t
Message-ID: <YrIMZirGoE0VIO45@do-x1extreme>
References: <20220621141454.2914719-1-brauner@kernel.org>
 <20220621141454.2914719-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621141454.2914719-2-brauner@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 21, 2022 at 04:14:47PM +0200, Christian Brauner wrote:
> +/**
> + * kuid_eq_vfsuid - check whether kuid and vfsuid have the same value
> + * @kuid: the kuid to compare
> + * @vfsuid: the vfsuid to compare
> + *
> + * Check whether @kuid and @vfsuid have the same values.
> + *
> + * Return: true if @kuid and @vfsuid have the same value, false if not.
> + */
> +static inline bool kuid_eq_vfsuid(kuid_t kuid, vfsuid_t vfsuid)
> +{
> +	return __vfsuid_val(vfsuid) == __kuid_val(kuid);
> +}

Something that I think would be helpful is if this and other comparison
functions always returned false for comparisons with invalid, e.g.:

static inline bool kuid_eq_vfsuid(kuid_t kuid, vfsuid_t vfsuid)
{
        return vfsuid_valid(vfsuid) && __vfsuid_val(vfsuid) == __kuid_val(kuid);
}

I can't imagine any cases where we would want even two invalid ids to
evaluate as being equal, and so as it is now we have to take great care
to ensure that we never end up with comparisons between two invalid ids.

Honestly I'd like to see that for kuid_t comparisons too, but I suppose
that's a little out of scope here.

Seth
