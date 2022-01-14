Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A044048E4D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 08:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiANH0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiANH0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:26:36 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F87C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 23:26:36 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id d189so5346603vkg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jan 2022 23:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=SMLXzMcZxNfgYCaDsKm7cLIDrF8nP/ZOqIarHM/nmX4xR3P5sgJLMLzrD95f9Nmgzw
         l9Vsr7Y+OmrsKYJSQv4tuIefNwKUywNkzH14N2HjGY1H6q15w5KSgQi70wesB4JrttMK
         6OgN4MNM24z+UU/SgzlrUjiLLmKRUvn51kc6jMTVyEcdCpKK4/dd8OLcvoR+6y0C8gyd
         stQa4kiSUhd31lh9lIB6FePd0aBPw2Oupuj57aewx4Kx3zKZJ5bVZxVep9NDgjgyuFZF
         PABYxmn7g0/jCw47FIRNf14OZJrSw1IUn/dStWrYAvbeBCdQU50IXY8EU1UBWQ2Fd1rg
         AW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=GOYR6FTNlTNbkV7R3WK1ISY8Pfj61tVfDiz2O5mzKl1TrgUy/ncp293eFL9fsOog6A
         smrKdtbyh19fPdfChe4vdXh4INMbTsAIafUC+jzGJDyLPbGa9wv8McAE36F6BQWZqoFV
         RDJjKv/+lS+k1+hHbeWz9RshZqZgyEU9ItP0u5P/erIIBEJfXbOmMAEedH3s3nNS1inN
         SlgluIwJh6oB2CvHS+TEkjNq7KgN55F0HmUxCmY2ZkkWG+Qg+ZpckHUXRJiIKnSty5ZH
         HvDrVQjwUJZXZbgyBKIEbz8tKp7EPwFBPueXYVD7iR/mVENgvYJk8zi/nD4ooA22mdEu
         m8hQ==
X-Gm-Message-State: AOAM533rIiJZuuJZSU12y6+a8VggkedmWYcULUdz5kRp6l/YuFLOcnM1
        varj+FykJGrWE6RzIQqMwMKwl9EOD/eDo1qCNdY=
X-Google-Smtp-Source: ABdhPJwl0adVZ7gifPjR7Y9qvC3pKYKnCjt6PVIJFTq7rmZLwfDabgbxCwekAT+xLnYSFclApI5UD3FBXvr9M/zDl7Y=
X-Received: by 2002:a05:6122:180d:: with SMTP id ay13mr475047vkb.5.1642145195271;
 Thu, 13 Jan 2022 23:26:35 -0800 (PST)
MIME-Version: 1.0
Reply-To: kl621816@gmail.com
Sender: la621816@gmail.com
Received: by 2002:a05:6102:213a:0:0:0:0 with HTTP; Thu, 13 Jan 2022 23:26:34
 -0800 (PST)
From:   "Mr Ali Musa." <hippolytepilabre@gmail.com>
Date:   Thu, 13 Jan 2022 19:26:34 -1200
X-Google-Sender-Auth: VJy0Eo7N9GtKCtd1D0Y4d-zTTE8
Message-ID: <CAEfXncCZJANyG_witk7+HXExgWuhkq7E73oHQrHEg2vCKfHPAQ@mail.gmail.com>
Subject: INTRODUCTION:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Friend,

 How are you today, Please accept my sincere apologies if my email
does not meet your business or personal ethics, I really like to have
a good relationship with you, and I have a special reason why I
decided to contact you because of the urgency of my situation here.I
came across your e-mail contact prior to a private search while in
need of your assistance.

INTRODUCTION: Am Mr Ali Musa a Banker and in one way or the other was
hoping you will cooperate with me as a partner in a project of
transferring an abandoned fund of a late customer of the bank worth of

$18,000,000 (Eighteen Million Dollars US).

This will be disbursed or shared between the both of us in these
percentages, 55% for me and 45% for you. Contact me immediately if
that is alright with you so that we can enter in agreement before we
start

processing for the transfer of the funds. If you are satisfied with
this proposal, please provide the below details for the Mutual
Confidentiality Agreement:

1. Full Name and Address

2. Occupation and Country of Origin

3. Telephone Number

4. A scan copy of your identification

I wait for your response so that we can commence on this transaction
as soon as possible.

Regards,
Mr Ali Musa.
