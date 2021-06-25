Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22683B48EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYSrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhFYSrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 14:47:35 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33EC061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jun 2021 11:45:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k16so13581389ios.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jun 2021 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=HLQ6RlfTa6OAVJUZenGuwLsa+C/hitwUxSIX0Xw5pjg=;
        b=ZQ6XOcwNJi4dE1QgMzStBjQEApXg4f3vv+xCBNXVsi1JWH5ywFujYFUjy5O6Kgu1M7
         gBY5i7Zz9JJTgSFh7y1njLROJ0o46zarei9k8dVOCa9eZG3avHpGdRcSXwe2UoO19OvC
         dr4Ix5Yn0JNwiTs0+cnRzLY7DkmnOKpEG3DAzaEKqrJ/eqbj81aovAVIRbPPRPbDZH7J
         F5hzxhOHZcgc35Y7vVXBM9qvUJW6WRtWNXfFpN4RjJdKedTRdwdOAqnsr0mXoF1REqiX
         nHnETMzPA2Ukn17YUOnFmi0TqFva3Vln8v7MvYDs7G50XgVm3wXfR3a37frlpIPX+eLH
         7PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=HLQ6RlfTa6OAVJUZenGuwLsa+C/hitwUxSIX0Xw5pjg=;
        b=eDRu2/q7jmhFgakMaGxGmLhpGdYSzdN0ihP4oKsS8Cs2DNJUZT85LIanmUAULhe1xg
         xgmJeNuQtepO0VoiApKYKxlc/0RpgilaJiWgpP0Ze8L1T/8y1KqZTounzSq+SlsHZdKb
         jpguoxMN1HmIDHCe4E9hKsNKg9gtXgXFCEcEJHvfA66MvumhrouECt051KLDQLpFhekW
         MjvQ5dz2fZCslAXQUfThFxeKopShL/TH57UrPbWNymTz9F2qCCAnF6ZcDMoRtY8lYz7E
         IxHF4E64JOJKiWp5sj72t+nsQXG6TKkR7yCcNxV4YT8uMnJy0/L5Fc8XLiFYKpdGwoWW
         GV0w==
X-Gm-Message-State: AOAM533IuPDyhHo8amQETYq0cTADnzdZuqtN78lyeJ94PuRyGczO9EaR
        feID3ocd5Vw+SeyxQpgu6Ji9bv6U9pFsNAjyoI4=
X-Google-Smtp-Source: ABdhPJxq8+mx9VDBmH7GcgwDiPh6yOaI4oqlTKJ86/zcFmT0zdyQIaUxqS6OzYhjo4WW5ZmSDzFIDTGfM4D/8DRtW8s=
X-Received: by 2002:a05:6638:120c:: with SMTP id n12mr10883239jas.7.1624646713220;
 Fri, 25 Jun 2021 11:45:13 -0700 (PDT)
MIME-Version: 1.0
Sender: yildizgabriele00@gmail.com
Received: by 2002:a05:6638:d08:0:0:0:0 with HTTP; Fri, 25 Jun 2021 11:45:12
 -0700 (PDT)
From:   Mrs Francisca John Carlsen <franciscacarlsen20@gmail.com>
Date:   Fri, 25 Jun 2021 19:45:12 +0100
X-Google-Sender-Auth: 1J5aqG19Lw2zImYx3H8kRKLa2qk
Message-ID: <CAHhmUS2xnSWCwYSWTTpYH6MH91C43Lj4gT1VN0ThXV8piAinBg@mail.gmail.com>
Subject: My Dearest,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My Dearest,

   I know that this message may be a very big surprise to you, I sent
this mail praying it will found you in a good condition of health,
since I myself are in a very critical health condition in which I
sleep every night without knowing if I may be alive to see the next
day. I am Mrs. Francisca  Carlsen from Denmark wife of late Mr John
Carlsen, a widow suffering from long time illness. I have some funds I
inherited from my late husband, the sum of (eleven million dollars) my
Doctor told me recently that I have serious sickness which is cancer
problem. What disturbs me most is my stroke sickness.

Having known my  condition, I decided to donate this fund to a good
person that will utilize it the way i am going to instruct herein. I
need a very honest and God fearing person who can claim this money and
use it for Charity works, for orphanages, widows and also build
schools for less privileges that will be named after my late husband
if possible and to promote the word of God and the effort that the
house of God is maintained.

I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincerely and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

May God Bless you,
Mrs. Francisca Carlsen
