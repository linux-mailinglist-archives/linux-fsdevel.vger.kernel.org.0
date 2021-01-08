Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2DE2EF77C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbhAHSfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 13:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbhAHSfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:35:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B370C0612EA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 10:34:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r3so9945985wrt.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 10:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=e7pg80uF4hvinD5xxFFdGcoJSnPu6QoAYEa2ANOYIPI=;
        b=k9iXW073qzdVHb5KwnMYNrVipadScTLAkzyTavptz/upVn+6xi8feToH2HDfzeS0Tz
         BFmsHk2/QhZVB0BgnpYkgE7FCYvtCMBgJLMz+TdQDLzIIqEqkK6TtB71H/sWT4L+yXE3
         9OhvYP2Z9pLxTksufQODseq4+C36EXA4oMcQrezkpIZ23z2LBVZpvzcefDF4Z7T9oZPi
         Zkf+zyOdKEo7BEpCMDvI+yl49xmkE+Ho4Y/sae3/E4pFM4J3kxWK+iwdcMXbf3kxq58I
         JPm8s2bbBrI0zEtUiGE/hTGQm/HauVbiquh2dKP7aHjUbGN5sMJMniE97mmeC4w9AWqN
         Cv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=e7pg80uF4hvinD5xxFFdGcoJSnPu6QoAYEa2ANOYIPI=;
        b=NXWpnbmATrHouJqda/SpqSNAYpPYEJDVmf4HiubxkQziQ5ACsVAYJVdC7xcksFa9Ts
         SnztZp2knugM3Bqt2DZsmYqdMR9H8vn5BjQFSxmn5eyDqLVYQkkKzCT5jj51mlD9mO+t
         bc2l8DemcDMXtHlc3s+MGXHAVwR6HesdwyiH/6rYqfoEtSJ8OUXSoxjApVb7tU2fKDnN
         q7ZVt+VvEM6DrVDcJ4VvO2FStQM+JuWK+2K9+DT8lJtkTvjTU2NFyXNO6Kbr5CbY98Sc
         Z76wY+Gvl+1YW7CM0Z5AoHaqtS6wo0LQNkJLr8ovoGxoWV7EwmluOhFLlC99TX84KkHB
         aRaQ==
X-Gm-Message-State: AOAM530tIOoEuGad0IfBNWnHUIdQAPaIaUqM8IZVwDt2MS/TxQm3B26C
        GW/beUxdxldh6CCMOmDMEy4gRE+ODSeNSPycgYY=
X-Google-Smtp-Source: ABdhPJyKgLy6kRfSVF3lNhi5RoQG/B//IrxEqT8/TJrnQy/aS+skw1HXhaPkO/1lf/x26+oQNEn9c4XJMitJSqQi4RE=
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr4837750wrt.287.1610130875658;
 Fri, 08 Jan 2021 10:34:35 -0800 (PST)
MIME-Version: 1.0
Reply-To: mrsdaniella.kyle@yandex.com
Sender: alfonsoblack2@gmail.com
Received: by 2002:a05:6000:1811:0:0:0:0 with HTTP; Fri, 8 Jan 2021 10:34:35
 -0800 (PST)
From:   Mrs Daniella Kyle <mrsdaniellakyle6@gmail.com>
Date:   Fri, 8 Jan 2021 10:34:35 -0800
X-Google-Sender-Auth: P-CECdCIp-no0P9ISq3YQXopDL4
Message-ID: <CAOzfzms4Y=Yt25_qP4gFhLVSFHoQ1hExfoBFmiYfbF-mxQCEpQ@mail.gmail.com>
Subject: ATM Visa card compensation, Thanks for your past effort
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

How are you, hope all is well with you?

This message might come to you as surprises, It is a very joyful
moment for me to share this good news to you today, although i have
really missed you because you give me the faith to carry on despite
all that happened,you really brought hope to my hopeless situation
then, therefore i made a vow to myself that even if we fail to
complete the transaction together,i must surely still compensate you.

To be very honest with you, It is a joyful moment for me and my family
right now, so therefore am using this opportunity to inform you that
have successfully move to Vietnam where am currently living with my
business partner who assisted me to complete the transfer, but due to
the willingness and acceptance you showed during my pain have decided
to willingly compensated you and show my gratitude to you with these
sum of $750,000.00 Seven Hundred and fifty Thousand US Dollars).

I want you to accept it as a gift from the bottom of my heart, Have
issued the check and I instructed the bank to roll the fund on an ATM
credit card for
security reasons,you can use the ATM card to withdraw money from any
ATM machine world wide with a maximum of US$10,000 daily.

This vow I made to myself about compensating you has been in my mind
so I am here to fulfill it to you, although I did not tell you what
was in my mind, my bank account manager said you can receive the card
and use it anywhere in this global world. Go ahead contact the Global
ATM Alliance directly with this below information. Email Address:
..... atmcardroyaldepartment106@outlook.com

 Name: ........... ....... Global ATM Visa Card Alliance
Office Address; ...... 01BP 23 Rue Des Grands Moulins.Ouagadougou, Burkina faso
Email Address: ..... [atmcardroyaldepartment106@outlook.com]
Name Of Manager In charge: Mrs Zoure Gueratou

Ask the manager to send you the ATM card and the pin code of the ATM
card that i gave to you as compensation, So feel free and get in
touched directly with the ATM office and instruct him where to send
you the ATM card so that you can start to withdraw the money. Please
do let me know immediately you receive it so that we can share the joy
of your success.

Presently I am very busy here in Vietnam because of the investment
projects which I and my new partner are having at hand, I have given
instructions to the ATM Visa card office on your behalf to release the
ATM card which I gave to you as compensation. Therefore feel free and
get in touch with him and he shall send the ATM card for you in order
for you to start withdrawing the compensation money without delay.

I and my family wish you best of luck in whatever business you shall
invest this money into. Kindly let me know as soon you received the
ATM visa card together with the pin code at your disposal.

Thank you
Yours Sincerely
Mrs Daniella Kyle
