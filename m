Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367963CAFCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 01:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhGOX4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 19:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhGOX4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:56:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9128C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 16:53:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p22so7186202pfh.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 16:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QkVHVo0TjyGhherk0gO6fRpU+Zs9TVxvFrpPJDqJibk=;
        b=hsTejQBqQSTsZoGaQTxaeGIOB3mdtHIh5IsnYs9BRzt722UovbzFZufmfKqlMlNczm
         5kQSKma5PWINtsko6lJQncTPEXPHpTvTpaoS0OEG835Y080vurEosl0Q9eQtRJRPxTTM
         /zIiJx2Ei/gkjk2umiwfrEFHEQI4quq5cSc7BfEKyqxzxQpBbha6YGCSgVOOFF9amJj8
         pIV+k8F2Jq8b7L7leNMjPJ93zKhasYgwNSIEpWZjRSZaUcHs3dXmut80F6d7NctxRl5U
         yVrS5hgo7nYn8zndAyY04WabCpTFA78zasiiApJGDKjFG9wPMPEPM2EA6VGrLMSWfv/p
         2cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkVHVo0TjyGhherk0gO6fRpU+Zs9TVxvFrpPJDqJibk=;
        b=suSP9iRGAOsQknwNrxBwPFi16iF/TP2q/gqYekk4vBvxY8aXT4p/EL/+TMsrtz87Ok
         SXUF9Aakvci5GfrmXBsMCMShVHYz3pcDqwlCz8zEm3jS/Yk4yM/DaY7qIk1tLA8VxKti
         e3ZvnruK/W+oAl29TAmz/ewE1D6NmG5TFzBDQyw3punbtPkpL+mtv4MbGc81eCuKkWE6
         ABavq+I+9jN9WwqsqlX9WEK66oTOEzRj/kyCN1oAYv4pgz47SM34rrXSsYWTRbRY365m
         67eJ/ExByHmMG9Owa1S+xDQm3eZ7xuck421U1yK4LkDdf1fe4gqTdVcwfVG0tZQrGoB6
         RJVA==
X-Gm-Message-State: AOAM532M8EQBclHUm9Oi7RPN8MOqjQGM1eAxR1AsSE3IyBTRQ4fATbEV
        oXzlrxQPRDnJ5ALg/13atbkUqQ==
X-Google-Smtp-Source: ABdhPJxujZd7Q2x9S3y2uK0ZEKcrdUpwH9QUlNAkdwfvlmpeh7pO1udE7SznyFYD9XOtbp00D47vFQ==
X-Received: by 2002:a63:770c:: with SMTP id s12mr2266967pgc.339.1626393207167;
        Thu, 15 Jul 2021 16:53:27 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:333f:3c28:f69:7ba4])
        by smtp.gmail.com with ESMTPSA id k25sm7531946pfa.213.2021.07.15.16.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 16:53:26 -0700 (PDT)
Date:   Fri, 16 Jul 2021 09:53:15 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: FAN_REPORT_CHILD_FID
Message-ID: <YPDKa0tZ+kIoT8Um@google.com>
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz>
 <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz>
 <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
 <YO469q9T7h0LBlIT@google.com>
 <CAOQ4uxgkMrMiNNA=Y2OKP4XYoiDMMZLZshzyviirmRzwQvjr2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgkMrMiNNA=Y2OKP4XYoiDMMZLZshzyviirmRzwQvjr2w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 03:09:56PM +0300, Amir Goldstein wrote:
> On Wed, Jul 14, 2021 at 4:16 AM Matthew Bobrowski <repnop@google.com> wrote:
> > On Mon, Jul 12, 2021 at 09:08:18PM +0300, Amir Goldstein wrote:
> > > On Mon, Jul 12, 2021 at 7:26 PM Jan Kara <jack@suse.cz> wrote:
> > > > On Mon 12-07-21 16:00:54, Amir Goldstein wrote:
> > > > Just a brainstorming idea: How about creating new event FAN_RENAME that
> > > > would report two DFIDs (if it is cross directory rename)?
> > >
> > > I like the idea, but it would have to be two DFID_NAME is case of
> > > FAN_REPORT_DFID_NAME and also for same parent rename
> > > to be consistent.
> >
> > I don't have much to add to this conversation, but I'm just curious here.
> >
> > If we do require two separate DFID_NAME record objects in the case of cross
> > directory rename operations, how does an event listener distinguish the
> > difference between which is which i.e. moved_{from/to}?  To me, this
> > implies that the event listener is expected to rely on specific
> > supplemental information object ordering, which to my knowledge is a
> > contract that we had always wanted to avoid drawing.
> >
> 
> I think the records should not rely on ordering, but on self describing types,
> such as FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO}
> but I am trying to think of better names.

Right, having such information types would work nicely IMO. I had something
like that in mind, but I just wanted to make sure that we weren't building
some reliance on the ordering of these information records as we recently
discussed not doing exactly that.

As far as the naming goes, FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO} is a
little bit of a mouth full IMO, but at this stage I haven't thought of any
better alternatives.

> I am still debating with myself between adding a new event type
> (FAN_RENAME), adding a new report flag (FAN_REPORT_TARGET_FID)
> that adds info records to existing MOVE_ events or some combination.

Well, if we went with adding a new event FAN_RENAME and specifying that
resulted in the generation of additional
FAN_EVENT_INFO_TYPE_DFID_NAME_{FROM,TO} information record types for an
event, wouldn't it be weird as it doesn't follow the conventional mechanism
of a listener asking for additional information records? As in,
traditionally we'd intialize the notification group with a flag and then
that flag controls whether or not one is permitted to receive events of a
particular type that may or may not include information records?

Maybe a combination approach is needed in this instance, but this doesn't
necessarily simplify things when attempting to document the API semantics
IMO.

> My goal is to minimize the man page size and complexity.

Either approach, I think they'll be significant documentation changes that
are needed. :)

/M
