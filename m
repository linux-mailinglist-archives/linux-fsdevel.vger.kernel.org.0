Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3383E36E1E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 01:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhD1Wye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 18:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbhD1Wy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:54:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A9CC06138C
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 15:53:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t2-20020a17090a0242b0290155433387beso3898870pje.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZ7QHc2ykOTQ3tVESh83HRmneBd7oEDH+LeHNMcXAHY=;
        b=cMV5Vtn9qduFGokuJESHEgCSHOAYUgReeSgxCag9K7Nc4Kq2A5h4tyP+iKqa03Jmdj
         WDkpHheGiMG1xt/XzEnpetDqoojsx/EIxeOw3p469HRqrB85mRqQf9fHIcgBDsAMipiJ
         CzYooSJUHIbS6hsRNpOWa1e6xsLZjsfVe6KXtR2PxJst6qFBImZRO6OPO/JYZu8wkO2y
         93cbWbmIhqsFtorUdyDdg3319fk2qzpQ9kte3rLc79jE67HgSTygjcUe6npbPP1pmyhT
         ri0wYPI5ew2Dkk6s2UFFqzhlQH2w96d2XCvt5WNIo/AHMdIzkmBIYP+mmmQQc++KnVHX
         6+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZ7QHc2ykOTQ3tVESh83HRmneBd7oEDH+LeHNMcXAHY=;
        b=ARp0k06SS0SPF1eVIvh5Dbet1IsdYrNAJyR03efS9jijqd60zCwcKMpYfHfQLG1Tu7
         vxoGa1H3UWpNu4WuJ7ZFSqlFQG03Jx2eIHHlKn0j95Xt80ewN02OTXXMMS2KhS9cJVL+
         4mH2cH327F+dUuFg15t12jDjzvNE/4KOoGZ3k7LPR8EQCjCEGrf4fvZTg/d9t9tQpBrN
         GMyVM3B3m2Pnwq4VGektTUTjFQgwKx7KvC2EaFLc8DcLdud8r8p+6ueJYJDShoTMvROv
         rKDBGC6mlCtY2+H9YuwcC7d8dba+FfqLAHI3+tHReGv4cQVunaw1LYTMbfQY/NkuyVVX
         oq+Q==
X-Gm-Message-State: AOAM531Db2uLwPlEgklrpqb/tY9CFU1HmkKph0SVPK95saJo0wm1qiCw
        jMJpg+5btHWVGmK/btTE7iAxCw==
X-Google-Smtp-Source: ABdhPJxSw7sv6m8hQEf/6OcaSoGjSg7zqhzeIXlFaRLMxIzIbWUCMoXviVnCAdUcibOTru8NxAWmKA==
X-Received: by 2002:a17:90a:f3d1:: with SMTP id ha17mr6500911pjb.123.1619650423529;
        Wed, 28 Apr 2021 15:53:43 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3ae5:2a7f:7b15:7b41])
        by smtp.gmail.com with ESMTPSA id 31sm654376pgw.3.2021.04.28.15.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:53:42 -0700 (PDT)
Date:   Thu, 29 Apr 2021 08:53:31 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YInna8fT/WfUkV6+@google.com>
References: <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz>
 <YIIBheuHHCJeY6wJ@google.com>
 <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
 <YIJ/JHdaPv2oD+Jd@google.com>
 <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
 <YIaVbWu8up3RY7gf@google.com>
 <CAOQ4uxhp3khQ9Ln2g9s5WLEsb-Cv2vdsZTuYUgQx-DW6GR1RmQ@mail.gmail.com>
 <YIeGefkB+cHMsDse@google.com>
 <CAOQ4uxjAqh3xVpigrJe1k01Fy5-rJRxxLGw92BwWtU4zjr=Wjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjAqh3xVpigrJe1k01Fy5-rJRxxLGw92BwWtU4zjr=Wjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:14:05AM +0300, Amir Goldstein wrote:
> On Tue, Apr 27, 2021 at 6:35 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > On Mon, Apr 26, 2021 at 02:11:30PM +0300, Amir Goldstein wrote:
> > > > Amir, I was just thinking about this a little over the weekend and I
> > > > don't think we discussed how to handle the FAN_REPORT_PIDFD |
> > > > FAN_REPORT_FID and friends case? My immediate thought is to make
> > > > FAN_REPORT_PIDFD mutually exclusive with FAN_REPORT_FID and friends,
> > > > but then again receiving a pidfd along with FID events may be also
> > > > useful for some? What are your thoughts on this? If we don't go ahead
> > > > with mutual exclusion, then this multiple event types alongside struct
> > > > fanotify_event_metadata starts getting a little clunky, don't you
> > > > think?
> > > >
> > >
> > > The current format of an fanotify event already supports multiple info records:
> > >
> > > [fanotify_event_metadata]
> > > [[fanotify_event_info_header][event record #1]]
> > > [[fanotify_event_info_header][event record #2]]...
> > >
> > > (meta)->event_len is the total event length including all info records.
> > >
> > > For example, FAN_REPORT_FID | FAN_REPORT_DFID_MAME produces
> > > (for some events) two info records, one FAN_EVENT_INFO_TYPE_FID
> > > record and one FAN_EVENT_INFO_TYPE_DFID_NAME record.
> >
> > Ah, that's right! I now remember reviewing some patches associated
> > with the FID change series which mentioned the possibility of
> > receiving multiple FID info records. As the implementation currently
> > stands, AFAIK there's not possibility for fanotify to ever return more
> > than two info records, right?
> >
> > Is there any preference in terms of whether the new FAN_REPORT_PIDFD
> > info records precede or come after FAN_REPORT_FID/FAN_REPORT_DFID_NAME
> > info records in FAN_REPORT_FID or FAN_REPORT_FID |
> > FAN_REPORT_DFID_NAME configurations?
>
> Doesn't matter.

OK, fair.

> Your typical application would first filter by pid/pidfd and only if process
> matches the filters would it care to examine the event fid info, correct?

Not necessarily, but you're right, the ordering doesn't really matter
too much.

/M
