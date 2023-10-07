Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785047BC803
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 15:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbjJGNqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjJGNqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 09:46:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50951B6
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Oct 2023 06:46:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-50573e85ee0so3701325e87.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Oct 2023 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696686372; x=1697291172; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xcyw+adYDPsRwIxeb0Oc5zdqtyY9aa5DD+Cqd/EwR3M=;
        b=SMoqbuDBH0QLUGKPx9ZOQmskbxcx9k3OwATqtdbEad0AnnvWaWIijxUOeCDYDg39pF
         XTorhlhmeMptuilImATFFq5+KiGCTHsoe7x2HkT9lC00Cyr11Fm96FuUXTRVOGGmi1Ii
         SxcMFH6E8qR0dyS1HlqOsnsmVwYqTWfUHEYKXStcAN4F/6n54w/JacMfAVAULi2eGiqU
         EicdiYNit175RBPYcDnvB1jsEgp5xx6AXm+99x4EKXu3J3KDcNbz5rKf8TM4WFZSyP4D
         +1ucmxVyFM6G8MEHF8FznRa/nhLMDAKhm/uvKRK+nV4Z4ll1bhRUFOsRtwRiS/cQ5CaQ
         zWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696686372; x=1697291172;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xcyw+adYDPsRwIxeb0Oc5zdqtyY9aa5DD+Cqd/EwR3M=;
        b=NQ+5ACeTMbse+3gDzd5/aOmixzNJNNPYS0FDg8vYRcW6ov3bTxLTaz9BC58m7YOyXC
         Zr24mwEyFmSxHkbHx3ykaDdeWU7SGFKLYzdJePqlrZSThNrfOYaqGR+bZYFEk6WDemM8
         0l5gSBR8OCcqQyBPig0L3slV76iajWgRc1GUf3CeaT60hhwkON6mIuSjUMEhnUceNURn
         XVSlIPVVvPZS56XS0bQpY3zQnnlTM2DowUHoOFO8r/CqMCnZ/gJtLUJyeHasWT05Dk32
         VdB5PeDOMledQF2xf8NxdwS3+pUHEQY2cpsdGjxa1BjPvSCXWN42WD9Xnm6/OahFbc7L
         73Xg==
X-Gm-Message-State: AOJu0YzSBmUHYPzA8pcYLHHYvOmuGYX825117vKSq4W7mmOmAp4FZ96/
        OM5AA1vQhmd6xgdYaAIfXLps+kfI7QDStWK7oDg=
X-Google-Smtp-Source: AGHT+IHwjn/dpuI7whRjzT4excJfJnztRWbU4NA7Fm4KCD7acbDVFuxVM+tzNQq65UwHtZzdEQlzeAeAVduPdW37puo=
X-Received: by 2002:a19:385c:0:b0:4f8:6abe:5249 with SMTP id
 d28-20020a19385c000000b004f86abe5249mr8950386lfj.3.1696686371999; Sat, 07 Oct
 2023 06:46:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6022:554:b0:43:269e:e127 with HTTP; Sat, 7 Oct 2023
 06:46:11 -0700 (PDT)
Reply-To: alissazomma@gmail.com
From:   Alissa Zomma <victoiremian94@gmail.com>
Date:   Sat, 7 Oct 2023 14:46:11 +0100
Message-ID: <CAMoc5eQJEqvfttRiWzfbJRvDxz6O_MVAUk5JbXaYaNva-iNojw@mail.gmail.com>
Subject: From Alissa Zomma
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7163]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [victoiremian94[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [victoiremian94[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
Dear greetings,

Have you received my previous message?

I hope to read your

response soon.

Best regards,
Alissa Zomma
