Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA981858B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 03:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCOCUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 22:20:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37004 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCOCUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:20:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id 6so16921840wre.4;
        Sat, 14 Mar 2020 19:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PE24DoRnfKFZy52Nrv5UE52xwHWVoBxgf+ra2gpiIaw=;
        b=p8SRUlzvPABfmrEr4KF0tjpIdEQ+11vdcstDy0RA+Am3AirRl+HEt1jqh4Qcr4iHvQ
         oygo9HYIk+GCPliR5UuSc1kRj+AccKbVoW/u83m0p/mlnrdmpIveGvWIkluaNKOJBbnM
         BGV2B29W6/77StVMqHPo6koRSsZT2dtg8NJhjLJdJGtibJ/gqZXZYC2J1R2Wvey4Mj9V
         e2TzCKmGaw+ffg4CT+UA2ulDCCy98mSVHHpAYTD+vwQA79/T0CVO+K7ZIFnStSuSybsh
         6Onr/AYUx+739YiXcL23Svm05XVaF4dixrCzykKZmp+wY0ezy5RWPqT2zbkYbi9vjgLE
         O13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PE24DoRnfKFZy52Nrv5UE52xwHWVoBxgf+ra2gpiIaw=;
        b=W8fhA6cJgVc5pwV+AviufF5lu4VSH9WDQNExeOjCIMUmCyQjDOU3i7fYreinJQJM9h
         sRrpIlO6XEQD4Ii3MU5DkI6eLRr34MBAHnrMxz/e/U6QtYx+A3/OmX7Tk2mecUuzcDgS
         O9Sj3SzhHvoVlVuoU6fV+GkhhNBKrFAWB/Q3Whga7WdfaIoYw0/KheE69Ki+uV8b2OrI
         3JGuvblfRD9hh0/LuexHH6lszU2YoGzveFGB1RfFzMxRn397mUzovtA3CMlOaz65vC+O
         9ttUU3K/oxALoRVJucaid5yaS3gg8vQoUcIDwyNf9FFxfwYgNp09SXMtn6wWUOQymvCr
         RweA==
X-Gm-Message-State: ANhLgQ12hqLItPMLm+coM1P3pw8l2j3DvetGRrgB5eXmlRNzvg5uzseh
        jiopKTMJWxadl3XZxJjRovgICzbGV2c=
X-Google-Smtp-Source: ADFU+vuncf2glww4dZrO79kzBlarasrCAqQD6mQQhjf/qj63KdOmFMMtFHPRYj3tZtd1TwszZWC2Hw==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr20082853wrx.8.1584221703177;
        Sat, 14 Mar 2020 14:35:03 -0700 (PDT)
Received: from debian (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f9sm6660355wro.47.2020.03.14.14.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 14:35:02 -0700 (PDT)
Date:   Sat, 14 Mar 2020 21:35:00 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Paul Wise <pabs3@bonedaddy.net>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Ruffell <matthew.ruffell@canonical.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        Jakub Wilk <jwilk@jwilk.net>
Subject: Re: [PATCH 0/1] coredump: Fix null pointer dereference when
 kernel.core_pattern is "|"
Message-ID: <20200314213500.s7y4wyok2lfc4w6f@debian>
References: <20200220051015.14971-1-matthew.ruffell@canonical.com>
 <645fcbdfdd1321ff3e0afaafe7eccfd034e57748.camel@bonedaddy.net>
 <87a47997-3cde-bc86-423b-6154849183e9@canonical.com>
 <fa636317af3a38badff322ca11e437701154b1be.camel@bonedaddy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa636317af3a38badff322ca11e437701154b1be.camel@bonedaddy.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Paul,

On Sat, Mar 14, 2020 at 08:28:10AM +0800, Paul Wise wrote:
> On Tue, 2020-03-10 at 11:34 +1300, Matthew Ruffell wrote:
> 
> > Can I please get some feedback on this patch? Would be good to clear
> > up the null pointer dereference.

I could reproduce the problem very easily, though the core_pattern is
not supposed to be used that way. Only "|" is invalid core_pattern. But
in anycase I think the kernel should have a check for this invalid
usecase.

> 
> I had a thought about it, instead of using strlen, what about checking
> that the first item in the array is NUL or not? In the normal case this
> should be faster than strlen.

Why are you checking the corename in do_coredump() after it has done
almost everything? It can be very easily checked in format_corename().
Something like the following:

diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..d25bad2ed061 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -211,6 +211,8 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 			return -ENOMEM;
 		(*argv)[(*argc)++] = 0;
 		++pat_ptr;
+		if (!(*pat_ptr))
+			return -ENOMEM;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output


--
Regards
Sudip

