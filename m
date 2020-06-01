Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34731EA309
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 13:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgFALmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 07:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFALmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:42:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3857C061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 04:42:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 18so9000875iln.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2020 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=n2g1OFWeiCjmEINhgbujgT6DXdOsI+KJAmX6eSohPHlheKiwbe3SaCQ/0KIBXN40Pa
         fQqLk4GeEFRb4wdzLyW79Hf5bNps761LApAHMkJMaJZSAyOSl+ayP3kLFDMDrtmiMtm2
         FYogqp+Dc/0bQVfqtEzK1/GwmGrhgad+NsQQ+ddWeBtXW2f82BV2ZZdyEGTIvzIsPm27
         iYxOVNrhNQ0HcXtNUi7ITpOBH+0BRIAJBnX+X+BdWWxcE07wltO+Wu9PrFJsMvGIzbOa
         a4aOnXFw9ts951p7f6gj19hPS0MZZMm4gpWSpC2bl1sew4VMLrsU1fC0eNoYjHCI+CDb
         sTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=D4zl3SbYvxATTqyY/g4rbyuoI5CoixCqohUKgwTttCEgFNOUm0IDxR6NIYpTdAhT/7
         42LRhhEAmvY8+r5VyR4AYjjr9tcor4Kyq9Wtebc+N6PDGcOb4TJHgv3a81EruIZSnV/X
         kHiAIC5+MoVDF5oDmHH0/rUGq4qi8SqB1SkB19LU8P7OGVpA9HeVDan+AkLH56CsIBpv
         IjfzoUapVJOPmQgJhINS7m+BUbbyXaedRJ80dHF1VgY3DPPmfXeifHMzmhMzRF+b36KH
         BLL9d7xjfNOVGPNU2NAv00WNfF/H/917iaM2k6oGMUk+wny8DbXWqKkxHls622rbBeCV
         hTHA==
X-Gm-Message-State: AOAM531yFv+T602OZSU2Soc2LSO3dnGD+F938z4YwfG+aNI8Us8BrS54
        i9kOumwszZ0QZDTpgyv/G9xvJJiZ+/IyUx5Aaeg=
X-Google-Smtp-Source: ABdhPJzNbck6NjBNRg9aZwr069JXztBhqtmEmanGo8CrI3BiOUNJ/YC75OPxLNVvmBtXGKF/wi47Kfn3zmutRD7aGN8=
X-Received: by 2002:a92:5dd2:: with SMTP id e79mr19195331ilg.94.1591011724659;
 Mon, 01 Jun 2020 04:42:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:77a:0:0:0:0 with HTTP; Mon, 1 Jun 2020 04:42:02
 -0700 (PDT)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <photakachi@gmail.com>
Date:   Mon, 1 Jun 2020 04:42:02 -0700
Message-ID: <CAKTgzwyFF6ACaWp7C++_M8tPyzq8nESVHHMbxVjwjT63VWAbAA@mail.gmail.com>
Subject: =?UTF-8?B?0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsINCc0LXQvdGPINC30L7QstGD0YIg0JHQsNGA?=
        =?UTF-8?B?0YDQvtCx0LXRgNGCINCQ0L3QtNC10YDRgdC+0L0uINCvINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC?=
        =?UTF-8?B?0L3Ri9C5INC80LXQvdC10LTQttC10YAg0L/QviDRgNCw0LHQvtGC0LUg0YEg0LrQu9C40LXQvdGC0LA=?=
        =?UTF-8?B?0LzQuCDQv9C+0LrQvtC50L3QvtC80YMg0LrQu9C40LXQvdGC0YMuINCSIDIwMTUg0LPQvtC00YMg0Lw=?=
        =?UTF-8?B?0L7QuSDQutC70LjQtdC90YIg0L/QviDQuNC80LXQvdC4INCc0LjRgdGC0LXRgCDQmtCw0YDQu9C+0YEs?=
        =?UTF-8?B?INGB0LrQvtC90YfQsNC70YHRjywg0L/RgNC40YfQuNC90LAsINC/0L4g0LrQvtGC0L7RgNC+0Lkg0Y8g?=
        =?UTF-8?B?0YHQstGP0LfQsNC70YHRjyDRgSDQstCw0LzQuCwg0L/QvtGC0L7QvNGDINGH0YLQviDQstGLINC90L4=?=
        =?UTF-8?B?0YHQuNGC0LUg0YLRgyDQttC1INGE0LDQvNC40LvQuNGOINGBINGD0LzQtdGA0YjQuNC8LCDQuCDRjyA=?=
        =?UTF-8?B?0LzQvtCz0YMg0L/RgNC10LTRgdGC0LDQstC40YLRjCDQstCw0YEg0LrQsNC6INCx0LXQvdC10YTQuNGG?=
        =?UTF-8?B?0LjQsNGA0LAg0Lgg0LHQu9C40LbQsNC50YjQuNGFINGA0L7QtNGB0YLQstC10L3QvdC40LrQvtCyINCy?=
        =?UTF-8?B?INC80L7QuCDRgdGA0LXQtNGB0YLQstCwINC/0L7QutC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg?=
        =?UTF-8?B?0YLQviDQstGLINCx0YPQtNC10YLQtSDRgdGC0L7Rj9GC0Ywg0LrQsNC6INC10LPQviDQsdC70LjQttCw?=
        =?UTF-8?B?0LnRiNC40LUg0YDQvtC00YHRgtCy0LXQvdC90LjQutC4INC4INGC0YDQtdCx0L7QstCw0YLRjCDRgdGA?=
        =?UTF-8?B?0LXQtNGB0YLQstCwLiDQvtGB0YLQsNCy0LjQsiDQtNC10L3RjNCz0Lgg0L3QsNGB0LvQtdC00YHRgtCy?=
        =?UTF-8?B?0L4g0YHQtdC80Lgg0LzQuNC70LvQuNC+0L3QvtCyINC/0Y/RgtC40YHQvtGCINGC0YvRgdGP0Ycg0LQ=?=
        =?UTF-8?B?0L7Qu9C70LDRgNC+0LIg0KHQqNCQINCU0L7Qu9C70LDRgNGLICg3LDUwMCwwMDAsMDAg0LTQvtC70Ls=?=
        =?UTF-8?B?0LDRgNC+0LIg0KHQqNCQKS4g0JzQvtC5INC/0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQve+/vQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


