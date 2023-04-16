Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE8A6E3574
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDPGjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 02:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDPGjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:39:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BC9FB;
        Sat, 15 Apr 2023 23:39:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id lh8so9571907plb.1;
        Sat, 15 Apr 2023 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681627181; x=1684219181;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WLEmaRz/t7/0bxu6Fho8vlwfONiq1HrbGCC32FpRTPU=;
        b=Jsp3REzVngsf+Wll0T8yg4hdXEmPRyecu4Ekum6Vn+YkwoXK6UOSRT2u+kLkT+86BC
         6auOs0+UvI6mdBeNBwipxBE/VSgRU9ieKTucWd6BzaAU39YfspKRTo/ZTLVasgFbbd6p
         x/Ag4AGeNcxsZ/mdBTuyXQKgZ5EtUd2Kcxun9thMYCdLsAlUzrG/aZICPLxU28OOIMhL
         12uAoePstl98nyZu9DMNNMMxGujSnBxn3pp7pq9SxsaiV9rsAov8vDLy/CYPunbTyf9L
         wSrSi9Jys6tMTiVZ9lMX4o1ShkS9Hog8u2Qvdp+M3VoGpzgTW6w709i1ZHBrisiY8ETi
         3spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681627181; x=1684219181;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLEmaRz/t7/0bxu6Fho8vlwfONiq1HrbGCC32FpRTPU=;
        b=YnggqB8OYnctY8uu6zcLNSHSx+KdytVn5Y6/0Ba8V2/GsRsorz1fbVL3O+s24Db63I
         neIssl22cckslW75kL9EDGXkvTaIjI+TgcMGz2EB3pbVb/AWvcrWtCDUhs7DuyZjmqPv
         JdW/e6vmR5JhCA9g8mdboSqeTT0vB/rfisNQzZqIxHvo843udp3M2bliNPLOVRaNl2ZV
         05KgAVxsmxbkAOArUJ65decO+1Mk7nVLkgQmfGGkYRI+ZE0cBk6/D7giX3JE159la1Jt
         zRsJqIkmv8kKAF/bb6H/e7j4YwTh3sDTMFZ1U8++DbXutQAK151OxwWNtVBE7larXre9
         TAkg==
X-Gm-Message-State: AAQBX9eZ9R1s5ug1eedOoch1o0y7cUcWffTbQA8Pyv2xy/8fjGJZ2Ci7
        yBRNLtAuXEoCuvyEkisbqSo=
X-Google-Smtp-Source: AKy350ZhY42xXmw65SXaHoRq5n/6cAWGm0NJ8TtFX6OeDfpHALHj6BNMXRXW7ZUAkzUjTdVzQzUWMw==
X-Received: by 2002:a17:902:eccb:b0:1a6:a405:f714 with SMTP id a11-20020a170902eccb00b001a6a405f714mr8265879plh.63.1681627181198;
        Sat, 15 Apr 2023 23:39:41 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090aaf9800b0023d0c2f39f2sm6776742pjq.19.2023.04.15.23.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 23:39:40 -0700 (PDT)
Date:   Sun, 16 Apr 2023 17:24:25 +0530
Message-Id: <873550jb4e.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv4 9/9] iomap: Add couple of DIO tracepoints
In-Reply-To: <ZDuOtt6w+ZOcVv9w@infradead.org>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sat, Apr 15, 2023 at 01:14:30PM +0530, Ritesh Harjani (IBM) wrote:
>> Add iomap_dio_rw_queued and iomap_dio_complete tracepoint.
>> iomap_dio_rw_queued is mostly only to know that the request was queued
>> and -EIOCBQUEUED was returned. It is mostly iomap_dio_complete which has
>> all the details.
>
> Everything that is here looks good to me.  But it seems like we lost
> the _begin tracepoint?

Sorry, my bad, I might have only partially understood your review
comment then. Will quickly send the next rev.
So in the next rev. will only just add a _begin tracepoint in
__iomap_dio_rw() function. Rest everything should be as is.

Right?
