Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67333E0289
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 15:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbhHDN4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhHDN4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:56:31 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C453C0613D5
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Aug 2021 06:56:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p145so4082276ybg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XdkjCkEbpHg5nd+jg1mbTbTC48Xz0zrIT+9qtD4A290=;
        b=n7FuXSl/Sls7PmGWYsuMrdBXwwTfbO4HyWIdnVEG6dKGz1KtWPdyMfsKxxPgmRsDSl
         XE6E1wsZijIhWPkzjn1/nF3Am+Zyoj4Z5fLARZmUlEOtiDY4gb6qc7VXNGmPKXvK+kXk
         T2LRnNOMJIZcb6zd6Z2sIFXMHvdICj68tMAcBzbVpwWugDd5JYtg6LXsj0u441l8bHlV
         eewa/TELhY7Zf9Ci3Mue1HEvJBxRnT1FD7Otbw1iA0f3d/S5XYJ0Pi/QlaUEAMUzvHEh
         VmDYO+0Y8FmC8IiCizODCpeAfd+VYSa79v7sGNKPIa3SCNZDV1UNaRJ7JHRbZwBYtrsu
         qzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XdkjCkEbpHg5nd+jg1mbTbTC48Xz0zrIT+9qtD4A290=;
        b=tUuBJKNxzEdz5dkBh2w/dKggOCi4q5GbXARY7QfScFlCeBHpLwpTbugMhLdPEhP6BK
         3efazH2KsjE+9SJUAs/UzV7rEZM6wtoa2RARknSi+ENrCZFG6nc5EaUX5U/b23ETpRMm
         UAM0TUcbXKFuUwHvBkOtIMDESeHMPMo1nRdigh4KxvjbfbGLgjFB6uA1MEH68Xj55pb2
         2pcaysWuuCDw19dCBlr4pES+ylJ9Bg2bZybBNHdACboFxGl5M/hbTvPk6dRwtb/uFY3j
         /wSebOIZoLa0tOk4/pCEY2GQvd2up+tpiAGxqqCUYmmlzDgrBTXi+uhhQHNbSy9Xr4tL
         OgjQ==
X-Gm-Message-State: AOAM530kRj68owVQ3T9CSPIh7hwk0Rv8eCmzVy9HmPhZotTYFCX5zy/U
        Ie+Rk2oxbXmMDo/fKsnh/yBEnWw+dSj0z8v7Xcw3r8YWJg==
X-Google-Smtp-Source: ABdhPJwyOiIcsgEIhoYi89iWEWEaUPHqqxP48cazWEjYWv9eVBD5pXAhaJr2hmtj8mrEV1aqZig5L591xK1EqmukPvs=
X-Received: by 2002:a25:a109:: with SMTP id z9mr3801742ybh.279.1628085366144;
 Wed, 04 Aug 2021 06:56:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: d807vfh57p@gmail.com
Sender: ft4757ghg@gmail.com
Received: by 2002:a05:7108:2c8a:0:0:0:0 with HTTP; Wed, 4 Aug 2021 06:56:05
 -0700 (PDT)
From:   Dixie Prichard <m568987k@gmail.com>
Date:   Wed, 4 Aug 2021 14:56:05 +0100
X-Google-Sender-Auth: ba8kPuHi-xcVL7-QrlrzOo-wimQ
Message-ID: <CAK_-KPO_6F9RwJzX5p4hP69y3Yund8oCH=ENimiJyDAiGmPvMw@mail.gmail.com>
Subject: << Message From Mrs. Dixie Prichard >>
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please accept my apologies for writing a surprise letter to you. My
name is Mrs. Dixie Prichard. I'm the General Operation/Regional
Accountant of First Pillar Finance Bank, United Kingdom. I am the
account officer to one of our clients from your country who had a
project account with our bank in 2006 the valued sum of GBP=C2=A3
6,300,000.00 (Six Million Three Hundred Thousand British Pounds). He
was among the fatalities of the May 26, 2006 earthquake in Java,
Indonesia, which killed approximately 5,782 people. He was on a
business trip in Indonesia during this disaster that ended his life
and he did not specify a next heir when he opened the account.

I would like to introduce you to the bank as the beneficiary for this
transaction and invest the funds. Since you have a surname similar to
that of the deceased client, it will be easier for me to introduce you
to the bank management to release the fund. All I need is your sincere
cooperation and I promise this will be done under a legitimate
agreement that will protect us from any violation of the law. I agree
that 40% of this money will go to you as my foreign partner, 50% to
me, while 10% will go to establish a foundation for the
underprivileged people in your country. If you would like to hear me
out, I will provide you with full details about the transaction in
your reply to this letter.

Thank you for your urgent response.

Regards,
Mrs. Dixie Prichard
