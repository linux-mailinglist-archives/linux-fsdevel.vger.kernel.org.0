Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90B3D69F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 01:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhGZW1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhGZW1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 18:27:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB76C061757
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 16:07:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so2237538pjh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jul 2021 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sxoJWn9TB1KKIK9RMcPMr463nTvNmAuT8l6d2lNAt6w=;
        b=IttE0CeQ8dXkx8DCEsI5NCkLW794y07admt8aWMeu3joKj2oPeh+Mb361NQJKPVI+T
         MzB0w9wIQCfMl3YbYYPaaloKujShMMoIx3O7f0Vj7Ge7udHEW5kbXEYSngui0sC46J77
         XgdKrX5DjrDCVoktWZ/20cS2zQWRXgvRlXglTQW986jmQhZTs9baSNNJSkvgl4eAKt0b
         EYl9RMAJCffLJwcK8tDOCpk5hF0A0c+IlNiXXEBKoCL4Mv8tB63G1Cf6aPjNOl0wyFVD
         bGjz9wHhaPF6mUeD6kACLzQ5PvrS1j0vFNoIdkTPn6Ky7+66s3/RQph/t2eCYOhPsojz
         8WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxoJWn9TB1KKIK9RMcPMr463nTvNmAuT8l6d2lNAt6w=;
        b=ZZXQ5kWq+S4to4E0zspQkUOcAMQZU+9JohcUeEJ52K+ts1jiwhO/5vS89523Lz007k
         /RAkNg5AWG1ZigjjwEF1mX+Pp/hHSsrvRDNgs8/qxsQ8Qi7CXq7D2Kywgy2zAXVkyZX9
         L/9lCWDdDtorgO490ioStbHbpz2P+u8Vjx1kEpvg8H3/Z5c4/8rG9hwJ8SuWUMvhqMGI
         4mOH6eLHUoQN7S2e73Bb6UEQrxi1eJ4Z79P3Z4FWw3c2NMnTGiGh1nh0Mb9Okdm1XrgK
         pqUKB169e9uSdTOwyhnfGPBH9SeRyvmCIFbQv7CUS+/F1iTFtom40Ds5dZQTjIX0eca5
         H6vg==
X-Gm-Message-State: AOAM530VZoq9LAvK8iHsa1Fbgo+YJ/GC8synA/O/FJrNvW2bziJRBKXH
        DZcVHCa0dS+BTL+a7cj4Ct0qWg==
X-Google-Smtp-Source: ABdhPJy4GG9zZhu4cOzFgHHwxIdgpJiKeMNzec6n4+BGf5yNRSI/Pv3FIOvCg7RfbWRJqFu4WMIAEA==
X-Received: by 2002:aa7:9517:0:b029:35e:63f3:64a2 with SMTP id b23-20020aa795170000b029035e63f364a2mr20380909pfp.74.1627340861198;
        Mon, 26 Jul 2021 16:07:41 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c253:e6ea:83ee:c870])
        by smtp.gmail.com with ESMTPSA id x26sm1106821pfj.71.2021.07.26.16.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:07:40 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:07:28 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Add pidfd support to the fanotify API
Message-ID: <YP9AMGlGCuItQgJb@google.com>
References: <cover.1626845287.git.repnop@google.com>
 <CAOQ4uxhBYhQoZcbuzT+KsTuyndE7kEv4R8ZhRL-kQScyfADY2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhBYhQoZcbuzT+KsTuyndE7kEv4R8ZhRL-kQScyfADY2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:06:56AM +0300, Amir Goldstein wrote:
> On Wed, Jul 21, 2021 at 9:17 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Hey Jan/Amir/Christian,
> >
> > This is an updated version of the FAN_REPORT_PIDFD series which contains
> > the addressed nits from the previous review [0]. As per request, you can
> > also find the draft LTP tests here [1] and man-pages update for this new
> > API change here [2].
> >
> > [0] https://lore.kernel.org/linux-fsdevel/cover.1623282854.git.repnop@google.com/
> > [1] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v2
> > [2] https://github.com/matthewbobrowski/man-pages/commits/fanotify_pidfd_v1
> 
> FWIW, those test and man page drafts look good to me :)

Fantastic, thanks for the review!

I will adjust the minor comments/documentation on patch 5/5 and send
through an updated series.
/M
