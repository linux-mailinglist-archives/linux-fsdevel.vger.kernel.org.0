Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD63C7A82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 02:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhGNAVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 20:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbhGNAVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:21:44 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC8FC0613DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 17:18:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h4so148482pgp.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YILuWyfe6GXFMlRrJeKo1swCAPgOg98yYVF694DdW9c=;
        b=DLuisV1WS2RpGvQlO2Aa4nIdiMWqgkdMBJUbSkZLO4M9s4foQSYyLHt716KoYZTyzi
         Z60iKjkuUi3RVq93kM/ZxsDdl0iS2rc5M4PlZq9A/CfBi6ne4TteVfrF9SEda34v0n8+
         1uZFbVgt481yKtQNHy6aBIbHGlrg+p54q8gTVp7VMoYzDI+zYlSkEvZr9kovd+pDA2Hj
         Vosap6dfuLIruXFveMPh7NJDGPE6uCxvGJeNZnYjbCI8BK4WFjHlh5/dO2MBlam/76qu
         yirys4TvoG2eam4YI3DshdtmzrplbOI33J0cJKM+S6/lnElddsEotsIphab/ZvYCcxiP
         Edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YILuWyfe6GXFMlRrJeKo1swCAPgOg98yYVF694DdW9c=;
        b=hxd+DYlZTf3UA18UWtQK9gk7uutlrlLuI7+upix4TLs8mLhQxqNCX/xEefXFodwvMR
         BwJGmh4c4exsvgmUOtawUWICpTZRUUDJ2LN97N8Cp9xN2fe5esT+ug2YcyjUsBct1o/u
         Itg1GUiDUX1su6O7BznQ6aP2ltI0b6Z/ueeH1P+PtpcdrE1/8mSsn6CQHR1+/4kWub66
         903nfmDI0w3536vDHtpmTkRbC+Y31jI5GyJGxzAA8mxiARNEWXZgYrS1lEKx+TrhO4uK
         OX5bdjfw3k1X8Bq8g2fNhRo2HZP7FwhP6socbidQW/fDbVgyk1zFeXUMAF+2drZ2/66E
         Hc7Q==
X-Gm-Message-State: AOAM531hZn0rFoxDP9CypMFy/4lzwidq7yinxecjfNNr2oYZYeX65EGv
        3h7xXHSpX9xs8+h15Fkt8P2nqQ==
X-Google-Smtp-Source: ABdhPJxP6oXW9qMSQZPX4GuDh0/MR5PX5zS82dm9IkkJzfnsBDoKAftmOzZ9RgOYiv300rqMotvIdA==
X-Received: by 2002:a65:508a:: with SMTP id r10mr6678627pgp.96.1626221932808;
        Tue, 13 Jul 2021 17:18:52 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:8048:54c2:c50c:3d93])
        by smtp.gmail.com with ESMTPSA id t5sm266384pgb.58.2021.07.13.17.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:18:52 -0700 (PDT)
Date:   Wed, 14 Jul 2021 10:18:40 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <YO4tYLCD8SEeR/uW@google.com>
References: <cover.1623282854.git.repnop@google.com>
 <7f9d3b7815e72bfee92945cab51992f9db6533dd.1623282854.git.repnop@google.com>
 <CAOQ4uxj6-X4S7Jx1s2db5L+J5Syb2RE=1sGV-RJZahwgzOE-6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj6-X4S7Jx1s2db5L+J5Syb2RE=1sGV-RJZahwgzOE-6w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 10, 2021 at 05:49:57PM +0300, Amir Goldstein wrote:
> On Thu, Jun 10, 2021 at 3:22 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > allows userspace applications to control whether a pidfd info record
> > containing a pidfd is to be returned with each event.
> >
> > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > struct fanotify_event_info_pidfd object will be supplied alongside the
> > generic struct fanotify_event_metadata within a single event. This
> > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > the event structure is supplied to the userspace application. Usage of
> > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > permitted, and in this case a struct fanotify_event_info_pidfd object
> > will follow any struct fanotify_event_info_fid object.
> >
> > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > limited to privileged processes only i.e. listeners that are running
> > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > these initialisation flags with FAN_REPORT_PIDFD will result with
> > EINVAL being returned to the caller.
> >
> > In the event of a pidfd creation error, there are two types of error
> > values that can be reported back to the listener. There is
> > FAN_NOPIDFD, which will be reported in cases where the process
> > responsible for generating the event has terminated prior to fanotify
> > being able to create pidfd for event->pid via pidfd_create(). The
> > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > creation error occurred when calling pidfd_create().
> >
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> >
> 
> [...]
> 
> > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> > index fbf9c5c7dd59..5cb3e2369b96 100644
> > --- a/include/uapi/linux/fanotify.h
> > +++ b/include/uapi/linux/fanotify.h
> > @@ -55,6 +55,7 @@
> >  #define FAN_REPORT_FID         0x00000200      /* Report unique file id */
> >  #define FAN_REPORT_DIR_FID     0x00000400      /* Report unique directory id */
> >  #define FAN_REPORT_NAME                0x00000800      /* Report events with name */
> > +#define FAN_REPORT_PIDFD       0x00001000      /* Report pidfd for event->pid */
> >
> 
> Matthew,
> 
> One very minor comment.
> I have a patch in progress to add FAN_REPORT_CHILD_FID (for reporting fid
> of created inode) and it would be nice if we can reserve the flag space in the
> same block with the rest of the FID flags.
> 
> If its not a problem, maybe we could move FAN_REPORT_PIDFD up to 0x80
> right above FAN_REPORT_TID, which also happen to be related flags.

That's fine by me, no objections. Updated my patch series with the updated
flag value [0].

[0]
https://github.com/matthewbobrowski/linux/commit/02ba3581fee21c34bd986e093d9eb0b9897fa741#diff-c83e05fe10af36146658416e55756f304a099606f4a2b18d2fcb683b277c3c62R54

/M
