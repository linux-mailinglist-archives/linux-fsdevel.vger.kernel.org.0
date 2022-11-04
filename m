Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3261A0AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 20:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKDTPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiKDTPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:15:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904AB48740
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 12:15:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l6so5360658pjj.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 12:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=magic-biz-com.20210112.gappssmtp.com; s=20210112;
        h=importance:content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ofRwdNGKsSXQWAL575IjYG4/Ro8SKQwXP5co4yIqPM=;
        b=NNghSC7oUZqFD2I8hGsfTTw4ZJnoIWJ+6KmO2xPexKxHvHf1OWFaLvueqjqesXI3ph
         okivktAjr0eGgclM0MjjoWIp/ovE/mLh9Bu+XKSQdwb/jE8xpaiDXQXt6wJaltelp90/
         4YHkBLVphHhqDUtXQDoqzvMbRNbiO7+kk4jwlKy3GoufQ6xhOLypUK2dr6GuhgBYH1Kw
         HCC9tVD+p8Yx+JMXjzgbbB73tuX0NNSLfgwvBW0Kb1AuIuuCxuhAG6249reEOsf1iBlz
         5J9OqpJ1C0DJo4CutXJQNCkORxVXX3DEg18xGipMbnHbddBPfursPMK6W0glNLIUxnuK
         DY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=importance:content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ofRwdNGKsSXQWAL575IjYG4/Ro8SKQwXP5co4yIqPM=;
        b=xjqSxPyR7oPPDvBrt7wUB07AxRcxDuFGnVBU8IvbhmhkjCaBraQqNs91weDB0rIO2+
         j2aIkCXq6cZNdwyAcdMfN0ulwZicKLMMRCuk4VD3lYBy9aRgzzMNX2eMaVvqlIST30QI
         OJdCTinO6FueSBUgOwYly3uUBQOW+I7/Q52IaN4gPfDZmgI34ptuUleGLoTa51t4Ig1S
         yMkd8AD0z76FQV6loaRFO06GYkbWa0ujbm2qFYugmD0oKSkfoICKADehSuuAm/hbTWWy
         bwe3LMs42y7NXCVQp0hJaVA8L8gtgHX942zzFqOgRrDgJ/36Bn3QARCLWN37nt+awVEo
         Hp8A==
X-Gm-Message-State: ACrzQf0Spymnm4ZayMC6wezXjxlsOEq/zh68U3ccQ7vcPrJZ8WGTe7K9
        QwKmtw4PDbCcqcBoRos5kG9bFg==
X-Google-Smtp-Source: AMsMyM5fc4rhl3vlgeaeFbZB65763I4g+VmaJSvdQsL4sjhMQKhl7E974lKN0OSrPsZK4bDPEZsq8w==
X-Received: by 2002:a17:902:ebc7:b0:17e:7378:1da8 with SMTP id p7-20020a170902ebc700b0017e73781da8mr37129729plg.152.1667589341116;
        Fri, 04 Nov 2022 12:15:41 -0700 (PDT)
Received: from DESKTOP6C94MB6 ([2406:7400:63:f7e5:255b:7208:7bcc:6c8f])
        by smtp.gmail.com with ESMTPSA id l8-20020a17090a4d4800b0021301a63e86sm1987843pjh.18.2022.11.04.12.15.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Nov 2022 12:15:39 -0700 (PDT)
From:   "Maria Jones" <maria@magic-biz.com>
To:     <maria@magic-biz.com>
References: 
In-Reply-To: 
Subject: RE: RSNA Annual Meeting Attendees Email List-2022
Date:   Fri, 4 Nov 2022 14:16:11 -0500
Message-ID: <307401d8f082$7c96ec30$75c4c490$@magic-biz.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjwgRm21LfzgTN5RMyxxUOryxtsRQAABSRQAAABODAAAAAmcAAAACXQAAAAKFAAAAAmsAAAAC7gAAAAK9AAAAApUAAAAChQAAAAJ3AAAAAqMAAAADdgAAAAKIAAAAAoQAAAACswAAAAKcA=
Content-Language: en-us
Importance: High
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I hope you're doing great and staying healthy!

Would you be interested in acquiring Radiological Society of North America
Attendees Data List 2022?

List contains: Company Name, Contact Name, First Name, Middle Name, Last
Name, Title, Address, Street, City, Zip code, State, Country, Telephone,
Email address and more,

No of Contacts: - 40,385
Cost: $1,928

Looking forward for your response,

Kind Regards,
Maria Jones
Marketing Coordinator






