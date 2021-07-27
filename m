Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE313D6AF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 02:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhGZXg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 19:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhGZXgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:36:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFDEC061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 17:16:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so1476023pja.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DvAL8BIZtn88pM1FbAWa7kkXzZwzfNMWuqomFCIceN0=;
        b=Es6DFZy4zA4Yx73Y4HyMMk3U4wwTn/Yqx9MSEdsz4y9BsDNhNzXH3FDSq/g0bW2mlZ
         bOtKoScWDFiggx1qTO+bHbRSU7BxA4g19FbTp0XPjTsh+plMIMO4egJNAMyt1mpAwlCz
         +86WQ1JcMYWCTC3LnycQWAiBHNeDStcaaj1O3Gnjnj9GAOQCJUhGm0UI4lAoeiFelH5J
         ptX7/zoeTy4D9fErwHmMyvhUqd92QTXpplNR4I0ieTOVTfSUGJjGxCUdzfA7ShkKPvzF
         B1S9ZZZVJVkun8dReAic/ST/zPMbRE98QcHuSpIT2CvzFSKRN0fIU9oCoTr7xX8v1RAD
         9Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DvAL8BIZtn88pM1FbAWa7kkXzZwzfNMWuqomFCIceN0=;
        b=H1TbuKZxq3deq6/P5vz5QXz8Y6Pb7uS3URt14gYuFlKi6m8gFaLRKbY1UKmniIuoVC
         6QqJcMUtEPldQJrYzVuQ/cOm3SjRMPYwEvDtUSDEv7z+JsfVuu4b+RYlxDCyHsvg5BUz
         ZGbkyPxDThQeUWKKYJyi/OzsplY6zDHv0AcWmLKCaJwiaWktrr1WXoKX3BTA823vZ4Fu
         0Z2v74hCSVMagHP/c71aJq3swh9nVq7e407aEdUzcuz5zY5t9hR+XY+OBrDKF9pgkYiT
         rLCDxskHRaQGkoTgoWv8RUt9KIH+VZ5nY8rktoA/wSQfon5Dp9ngb3INpRRSP8tW+LLg
         SVOQ==
X-Gm-Message-State: AOAM530MdQkWwA2iYlXJdllXwUYUAtO6GfRMl7su+nym4JHhuRNNQrLZ
        TaHJD2vE6HkuCWnt6VgkWSGqvZdIqDypsQ==
X-Google-Smtp-Source: ABdhPJx3wIWowyiMyZmSHpcZHV2ZvUtudEuQ0/0dgMqpqCKyDTJ2cp2yQ8K4umidx0HSxjRDac02xA==
X-Received: by 2002:a63:594e:: with SMTP id j14mr20779817pgm.249.1627345012845;
        Mon, 26 Jul 2021 17:16:52 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c253:e6ea:83ee:c870])
        by smtp.gmail.com with ESMTPSA id o192sm1226116pfd.78.2021.07.26.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:16:52 -0700 (PDT)
Date:   Tue, 27 Jul 2021 10:16:40 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Add pidfd support to the fanotify API
Message-ID: <YP9QaEaCWvUV4Qie@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <CAOQ4uxhBYhQoZcbuzT+KsTuyndE7kEv4R8ZhRL-kQScyfADY2A@mail.gmail.com>
 <YP9AMGlGCuItQgJb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP9AMGlGCuItQgJb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 09:07:28AM +1000, Matthew Bobrowski wrote:
> On Wed, Jul 21, 2021 at 10:06:56AM +0300, Amir Goldstein wrote:
> > On Wed, Jul 21, 2021 at 9:17 AM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > Hey Jan/Amir/Christian,
> > >
> > > This is an updated version of the FAN_REPORT_PIDFD series which contains
> > > the addressed nits from the previous review [0]. As per request, you can
> > > also find the draft LTP tests here [1] and man-pages update for this new
> > > API change here [2].
> > >
> > > [0] https://lore.kernel.org/linux-fsdevel/cover.1623282854.git.repnop@google.com/
> > > [1] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v2
> > > [2] https://github.com/matthewbobrowski/man-pages/commits/fanotify_pidfd_v1
> > 
> > FWIW, those test and man page drafts look good to me :)
> 
> Fantastic, thanks for the review!
> 
> I will adjust the minor comments/documentation on patch 5/5 and send
> through an updated series.

Alright, so I've fixed up the git commit message and comment in the source
code so that it's more accurate in terms of when/why FAN_NOPIDFD is
reported.

I'm going to hold with sending through v4 until I have Jan also look peek
and poke at v3 as I want to avoid doing any unnecessary round trips.

/M
