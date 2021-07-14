Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848123C7AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbhGNBTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 21:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbhGNBTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 21:19:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF1C0613DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 18:16:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h4so356462pgp.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 18:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XurQJvxBh8swEQbBf8RW3CynPtWq1ocXW4TAaOIj/L0=;
        b=Tk4UPWrkCz1ftGN2yLaU5HejCqByw6z8EEbRe2VIPNuZ08Gza//pQ/OeXEU+9a+v7v
         PhNhffl2NKFBCdUkNhmdUbiQYgXIllXp5+dJ11qfQa9iaJ+Ncyy93BPzzaIU7y8+dO8z
         MSwbIv9SD7h3tcs1c9WNVxCCDfcMYwGLflfi8yFG/WSCgF8xxqN0gsooEKNKhT3MKaJQ
         7Mcv9xX0m6gn1w5zDXrJnNczOpWVX2540KFyyy1ViH0rU/wDWK/73H1jdJ7uQCscXfoE
         qQwLgSdXLJQXiiG4DRKz0KGdC7o+EW6ozci5p08NTU98YiC1xqr5Ls1NOgIoX3xUczfL
         piCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XurQJvxBh8swEQbBf8RW3CynPtWq1ocXW4TAaOIj/L0=;
        b=UeIXSO/HVH1NoHi2ynZLyz2LJjjUwqSskEAMuHLSm47nc1k6xQrYtgD0FY1teyVXHT
         FualNRJdLhQZkuT2pi3fpn6LUGm0lvdDuz4oxtuanBUfY6ORZgktGylt9bqVrOEEWRUM
         TZCXPz7brQixWFSwBULXgg/qdSaXWLPvO0BM7ELDZXUf7Jrh/IbnDEiiNEg6PBQT2ky/
         SPXEOtXaUPm5GIUJrjJaT5Djiaima/1SekonVVG3QtAY1R9DwuHYcJZuUm4r50hjTu0n
         69fumnfx1pbsS2mXvvKF3ljEzgVNyYCxOG6D5ILQweDaWoVUbbeD06qg8slCMWM1/IDx
         hGlA==
X-Gm-Message-State: AOAM532/AUPPskQWbdZ71nv6vsc/Di9tpjj7P5+S4OwnzWvQcTQrBs1w
        DYQ79NRr61SUUVj7S0scQkApfEV2ORBjZg==
X-Google-Smtp-Source: ABdhPJyh9M+Sl/QsA53Y5YGD3ia8PlG/aE7lZh/d758vFXmIljUdH+n6LWaY/XjxudN0IK1CAm+Qew==
X-Received: by 2002:a05:6a00:158e:b029:32b:9de5:a199 with SMTP id u14-20020a056a00158eb029032b9de5a199mr7176482pfk.76.1626225411482;
        Tue, 13 Jul 2021 18:16:51 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:8048:54c2:c50c:3d93])
        by smtp.gmail.com with ESMTPSA id d1sm353399pju.16.2021.07.13.18.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:16:50 -0700 (PDT)
Date:   Wed, 14 Jul 2021 11:16:38 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: FAN_REPORT_CHILD_FID
Message-ID: <YO469q9T7h0LBlIT@google.com>
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
 <20210712111016.GC26530@quack2.suse.cz>
 <CAOQ4uxgnbirvr-KSMQyz-PL+Q_FmBF_OfSmWFEu6B0TYN-w1tg@mail.gmail.com>
 <20210712162623.GA9804@quack2.suse.cz>
 <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgHeX3r4eJ=4OgksDnkddPqOs0a8JxP5VDFjEddmRcorA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 09:08:18PM +0300, Amir Goldstein wrote:
> On Mon, Jul 12, 2021 at 7:26 PM Jan Kara <jack@suse.cz> wrote:
> > On Mon 12-07-21 16:00:54, Amir Goldstein wrote:
> > Just a brainstorming idea: How about creating new event FAN_RENAME that
> > would report two DFIDs (if it is cross directory rename)?
> 
> I like the idea, but it would have to be two DFID_NAME is case of
> FAN_REPORT_DFID_NAME and also for same parent rename
> to be consistent.

I don't have much to add to this conversation, but I'm just curious here.

If we do require two separate DFID_NAME record objects in the case of cross
directory rename operations, how does an event listener distinguish the
difference between which is which i.e. moved_{from/to}?  To me, this
implies that the event listener is expected to rely on specific
supplemental information object ordering, which to my knowledge is a
contract that we had always wanted to avoid drawing.

/M
