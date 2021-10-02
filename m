Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE541FD57
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 19:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhJBRQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Oct 2021 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhJBRQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Oct 2021 13:16:54 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AFEC0613EC
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Oct 2021 10:15:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ba1so46887576edb.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Oct 2021 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=2BMZhUbe/xBRGXRcWq9F8f7z46XdWDlUhMFMilqFGQk=;
        b=GxODt0eNCnG7xc2XlXER0tyuqkeUaSmjibFdzv76OfofyDoEI1Lv714O4lrh59rfwx
         jb3SlVo+jRzIFsGECF7vsLFMkbGva+OwcA3hGy6xhyztUZ5ZtOE9iG6Rj59M2gnxn/PW
         8qc1eTrG/1YHBhkYraDx3KHW5NXNXZtwXfOGU8OrTk04ZlBRUACZlzZRfWJVaPalkkFl
         evrvFdaVyiYbVavj99BUvJUl4hXcQdMl6t92G8KR19JBa2BcUBgMqjsHX5srI4wauLvr
         /HOBY90akJ9TygBxY9kS4YCctsFarM5C63bE8i0U0uX+ZBh5y6hq4mL0IBh0H67rcRZN
         lpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=2BMZhUbe/xBRGXRcWq9F8f7z46XdWDlUhMFMilqFGQk=;
        b=CrdwWzHt1ZaWoxGGZ3E3g44Kq24F0RPPauhlF3+18I3/U+GVA8rHB9nHowhPELt3BU
         7USDHeo2j2TTU3nlq2ZY4AwnmYeHTuQBkmgGrYAD6m14RfVaMFN1lIaRDuFkRrYJyycF
         GSKzs4PeovjscLcuLsLSIUBjPgN5SwjlCggR0HWSXWYCqDpO5Kw9a+9CfsnD7I2sS/f/
         nUzYLiOT6fw9OcMeNWBQMyHvXOCd9RRQg/4S/DpJprE2VMgNUxvYCpMczQaBopQqmANP
         1Sf4RyXy0OqGaUoVzg4Eg93hS48sn/aAOxiSqNDqDLs1mDJIJYZZbwH/NuB6laYXGZsU
         U2qg==
X-Gm-Message-State: AOAM5311MqY3RYMwc7gSvwBjlirnjxve0doxZtaD2Xmil3YEKi+pV02N
        VBjmTb8eWBWBMuv8nOlBbmyjwtYFCDrYpmTIP8I=
X-Google-Smtp-Source: ABdhPJzWApakfUagkB55d1N3J/iX6yyJ6DuDz9dOAlrzq2xCoT+XgDtii/N+Xx1Q09IoOZ7HcuzZLmJGjnR8fxSWumU=
X-Received: by 2002:a50:cf86:: with SMTP id h6mr5242758edk.104.1633194906913;
 Sat, 02 Oct 2021 10:15:06 -0700 (PDT)
MIME-Version: 1.0
Sender: alimahazem02@gmail.com
Received: by 2002:a54:3f4c:0:0:0:0:0 with HTTP; Sat, 2 Oct 2021 10:15:06 -0700 (PDT)
From:   Anderson Thereza <anderson.thereza24@gmail.com>
Date:   Sat, 2 Oct 2021 10:15:06 -0700
X-Google-Sender-Auth: PzsHzxzcP0FeJAHUzFobkHo723s
Message-ID: <CABBDEbid99MWNgTuwUnqYUZAb+UhbUa5DY-YMzoqsf9nbonuLQ@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night without knowing if I may be alive to see the next day. I am Mrs.
theresa anderson, a widow suffering from a long time illness. I have
some funds I inherited from my late husband, the sum of
($11,000,000.00, Eleven Million Dollars) my Doctor told me recently
that I have serious sickness which is a cancer problem. What disturbs
me most is my stroke sickness. Having known my condition, I decided to
donate this fund to a good person that will utilize it the way I am
going to instruct herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

May God Bless you,
Mrs. theresa anderson.
