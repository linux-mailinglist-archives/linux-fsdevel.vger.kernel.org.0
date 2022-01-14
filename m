Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097D648E973
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiANLvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiANLu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:50:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9FCC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jan 2022 03:50:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso21821860pje.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jan 2022 03:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=h0ot/9Bfj6gbigRp33fTwcN2wrGdo9obxY37DOqaflo=;
        b=UqaivxmB0ISUX7Oxm9jowEz7vblhwOxA6yBvmSDo63xyf/A9m05dwaef2H4hQG//ih
         52izJHQLYd+2oefALvskRy5Vl77l3MUx05aT6BRXnQJQsQkXUPWKzi/qYh/aSrlFZl9T
         dBucxfQUaHE07JxQV+b+BWJkqt+5MNGZO7RZhoer/IrbC+vEclQlM72ZqdipGTpjLRuA
         Mi7ix5BUEN5M3tl7597uZvhJYMalDWN+mHr9EOLo6r+DRRCO99haSvC6JCTDSnQk8HTV
         m26VAn2IRX15EzbSClg9rKz0UclD+6UcaaIVBRRF3gfoGAU/P/0EbF+lH3pyAIRiJWNi
         n5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=h0ot/9Bfj6gbigRp33fTwcN2wrGdo9obxY37DOqaflo=;
        b=pjS6puFdyGh+S8dDj52doYB21+OqDDaIhjxYLDDw2a1bsRVfmEMeaI+Zc9ahhiHD38
         xDIgJH6EP3qzZMGZzwyVbqzadE9kispiLi92cN8Bo7qYxyfnghe1anN9nSQAKEtGbUoc
         Fe2w88PgMokpf7pjRPRVZGd7YHc60JpJ5LrEb7IHlNatfcHNywvGYcg8nggnJfETI/bd
         HUUqNOe3zSLWI/pGRL7ZrYCyQIxh+jydj6l/ZCbSTNJss+oKtt9PJOTQWJCF5ylgiFb1
         4QAGZux0+uBDv+DFRCvFhxEAlEcxCILGO53Cn/0WAPbYbqq4dSwwx2S9n/nkdIfdVwn3
         ++pQ==
X-Gm-Message-State: AOAM532PiDWsnNzYO7JEYYXV2qCKGAHYtsU6zgcQSMonlIi0FVfuCyvc
        LKry5Sb5PP9BOe3ZSGT/E1fJju3JTVjxrtAVlYA=
X-Google-Smtp-Source: ABdhPJxvzUq2BojFr3GJ3LgW3yay0UwwoxyQkCZqJ6B8tvdUcX7m3Ub9ENjMg5OHsf+d2rMGMMbwcs69dKf48Q1Ap9U=
X-Received: by 2002:a17:902:bd94:b0:149:c926:7c26 with SMTP id
 q20-20020a170902bd9400b00149c9267c26mr9198996pls.64.1642161058998; Fri, 14
 Jan 2022 03:50:58 -0800 (PST)
MIME-Version: 1.0
Reply-To: ymrzerbo@gmail.com
Sender: dr.siaokabore@gmail.com
Received: by 2002:a05:6a20:2318:b0:6b:2327:c203 with HTTP; Fri, 14 Jan 2022
 03:50:58 -0800 (PST)
From:   "Mr.Zerbo Yameogo" <ymrzerbo@gmail.com>
Date:   Fri, 14 Jan 2022 03:50:58 -0800
X-Google-Sender-Auth: 4JEhKKPWrxVMzx4GWmhnHzqfkaI
Message-ID: <CA+rg4NvygDH0MsaEZ4VPLEaXMsuK0GX+qEtefiM-HFqpwSpg4w@mail.gmail.com>
Subject: VERY VERY URGENT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

My Name is Mr.Zerbo Yameogo the Chief Operating Officer of  Bank of
Africa and I am in need of a reliable foreigner to carry out this
important deal.

An account was opened in my bank by one of my customers in the name of
MR. THOMAS BAHIA a Dutch National from Germany who made a fixed
deposit of $18,500,000.00 (Eighteen Million, Five Hundred Thousand
United States Dollars) and never show up again and I later discovered
that he died with his entire family members on a plane crash that
occurred in Libya on the 12th of May 2010 and below is a link for your
view.

http://www.nytimes.com/2010/05/13/world/middleeast/13libya.html

Now I want to present a foreigner as next of kin to late Thomas so we
can make the claim and you can contact me if you are interested so I
can give you more detailed information about this transaction. For the
sharing of the money will be shared in the ratio of 50% for me, 40%
for you and 10% to cover our expenses after the deal.

Please for further information and inquires feel free to contact me back
immediately for more explanation and better understanding I want you to
assure me your capability of handling this project with trust by providing
me your following information details such as:

(1)NAME..............
(2)AGE:................
(3)SEX:.....................
(4)PHONE NUMBER:.................
(5)OCCUPATION:................ .....
(6)YOUR COUNTRY:.....................

Please keep this absolutely confidential weather interested or not.

Thanks.

Mr.Zerbo Yameogo.
