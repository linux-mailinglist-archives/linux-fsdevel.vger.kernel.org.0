Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5A5B6168
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiILTEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiILTEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:04:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6D6158;
        Mon, 12 Sep 2022 12:04:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o25so16965254wrf.9;
        Mon, 12 Sep 2022 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=48FMx4l1UWBvR1ljlbzIMn5vRhhGmT/fX7WVF+/hN0c=;
        b=lXf8KWFGphPWtAMHN6kfAv51Gh+aSKX4kguZ9sUy3uTnKyhQV9RKSEMVPPcGuOLFEI
         xMlWmVRWcY+WycLxXx3rbL36NWGVBTqLI4aXMRpaeRzK2Ra8P571ORCs4739Doq4aha3
         LRhJbyRcm014UsI61DIm1io/ivhX3CHMFuubA5pX47yt96KuJnZur+xj5br5I4cNJf3m
         paVEzgGCQk5zAiqr5HNEDp6CaLU56Um6+vb0nfSoaqt70raTeL0yYahfOUEDGmHFVVtb
         NAyVOqXct4FiCy8xrWjeQ+AGLUa2Q9AN1hpsOhpahAEMTlYsGTC0rH3DOXyo2ZhWz4SQ
         ciBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=48FMx4l1UWBvR1ljlbzIMn5vRhhGmT/fX7WVF+/hN0c=;
        b=LBb7NkzfikoIBSFB2zXGVsOuN1cf6beC+O+h/PQFIsErfy1YnqgJ1s8jE8STFgEkGz
         qnEruOQw5HhxsIyTbsjbTwoKSgh+74pSOm4tdq/V+JX2UATmsZ4CaiuOSCVPAv35D6sL
         F7BJRyJv1lhu7nmw1kZCvYGXJsgjpe4ld8TrxO1QI3y2Fopf/P9ZwFmetytk0tkz8Jr+
         XjPVhfnwiyVNGWWaehvbJYgPamZy8lzbil90NyQ1U/cG1hCFi96yoOEw7Dn3B5n5ikAs
         hFaCGIYParvRs5f1djojFOcTsA8sSk1cl7DvK5gRwpQr0pRc6Wbf9+ctr+1N7nypJZ9z
         PTfw==
X-Gm-Message-State: ACgBeo0rX00p8YRDLeoyJqQqh96e2P/fuSJ1b6c15BOUwUuxX1vhEojg
        8m/tOtqB7N+8xBdFK0lcjsM=
X-Google-Smtp-Source: AA6agR61fOLvqKCy2kfAoBvIjD4H2H6IvVdo1kGbozCTyIec5zrApDIy0GkyOLUbEO1CjvcuIytljw==
X-Received: by 2002:adf:e24d:0:b0:22a:4a40:d5cc with SMTP id bl13-20020adfe24d000000b0022a4a40d5ccmr7201328wrb.494.1663009475503;
        Mon, 12 Sep 2022 12:04:35 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id c16-20020adfef50000000b0021f131de6aesm8106308wrp.34.2022.09.12.12.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 12:04:35 -0700 (PDT)
Date:   Mon, 12 Sep 2022 21:04:33 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v6 2/5] landlock: Support file truncation
Message-ID: <Yx+CwQF5u/I/LLDb@nuc>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-3-gnoack3000@gmail.com>
 <b5984fd3-6310-9803-8b33-99715beeccfb@digikod.net>
 <Yx9QMbOA3i2i12ve@nuc>
 <bce9b221-e379-7731-31c3-38df5cda6152@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bce9b221-e379-7731-31c3-38df5cda6152@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 08:37:09PM +0200, Mickaël Salaün wrote:
> 
> 
> On 12/09/2022 17:28, Günther Noack wrote:
> > On Fri, Sep 09, 2022 at 03:51:16PM +0200, Mickaël Salaün wrote:
> > > 
> > > On 08/09/2022 21:58, Günther Noack wrote:
> > > > diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> > > > index 8db7acf9109b..275ba5375839 100644
> > > > --- a/security/landlock/fs.h
> > > > +++ b/security/landlock/fs.h
> > > > +/**
> > > > + * struct landlock_file_security - File security blob
> > > > + *
> > > > + * This information is populated when opening a file in hook_file_open, and
> > > > + * tracks the relevant Landlock access rights that were available at the time
> > > > + * of opening the file. Other LSM hooks use these rights in order to authorize
> > > > + * operations on already opened files.
> > > > + */
 > > > > +struct landlock_file_security {
> > > > +	access_mask_t rights;
> > > 
> > > I think it would make it more consistent to name it "access" to be in line
> > > with struct landlock_layer and other types.
> > 
> > Done.
> 
> Hmm, actually, "allowed_access" is more explicit. We could use other
> access-related fields for other purposes (e.g. cache).

Makes sense, renamed to allowed_access.

—Günther

-- 
