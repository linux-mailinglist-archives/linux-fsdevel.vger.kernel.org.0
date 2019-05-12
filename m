Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BD1ACB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfELO47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 10:56:59 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:40200 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfELO47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 10:56:59 -0400
Received: by mail-ua1-f49.google.com with SMTP id d4so3867834uaj.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2019 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rrAfCKp4YgnokAQY/LA+VhU6dSy2U9pfkNJjyT621xk=;
        b=Veayu/QXyOlWJoMzzEwyDVtYkeZExTbR5PO8OmoMqVHaL8582QQSRdkF+8br58ivCb
         OhjaBgnXuc4TTzMCqWoBMLY5sLdEgRRucL5iRLnxl7Ku5l8CH3bIJIkjI2DiSFni/Nv0
         SWDAQFg0myRQfFfc1tmiQb2Nllzp/qN5cp9C/aadz+sFNZLctJiA1xGoOZgsgjumooj0
         MZo9slpg7RvRWL07jp56zdLhI4jKnqBHmL2A7zV4qAAxlgDCis6Seyk0H0qMvabZkljR
         cRx7c+Pm0QSCXCdBweENO4NJGkDwNeNFgfOVCXOyr7D8rkdMwVqEDCpeXMhh+Tb+l++h
         D92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rrAfCKp4YgnokAQY/LA+VhU6dSy2U9pfkNJjyT621xk=;
        b=pTULGNsQHfUi/yUJPDJug16z/71lsx6QEZTzt/IjueM2STLdtfssrTvyUreTBr2t77
         xZlmX8zXB7aLB93RKU3Vb9Nq//gn7ks1+OaCejVRMaSX9ITryqI57fsa/teosj0gNJ2Y
         DS2yl9t/Tkyw9VNzFPKr2I0DKLseaZH2iVlDj9fdfbDaWzGhElqjfw207foJukdC2lej
         tJ2GHdg7SCnFgxKYfd+2nGYw1g+UE1ApJk+23E3ioVuqXu68Mv0sUoZKaB9L9ouLZaLS
         mSsPaiqOlGFu3isQeHqRHADUt+gCMheR9VoGRgRdjV5ZfmwXbkH/xhBilRhH4cAY/Er9
         ikKQ==
X-Gm-Message-State: APjAAAVlokQjdL1yVAmAeRIJtOUhpq923phwHvTwljiTo4beR7B6I/zn
        RikGr+VoIBCxsqvzyEfaw1/x0Bxpc1ShzOIjBwrGe5Kj
X-Google-Smtp-Source: APXvYqzIUIyrcW09xaWFFH3ebA4ujDKzps4UYgSPAZoq00UBYJpRoHSUyDMitHzMgwZDy6LdiHEnjB/vQUzd+66tYmU=
X-Received: by 2002:a9f:3381:: with SMTP id p1mr3064313uab.40.1557673018243;
 Sun, 12 May 2019 07:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+49okpy=FUsZpc-WcBG9tMUwzgP7MYNuPPKN22BR=dq3HQ9tA@mail.gmail.com>
In-Reply-To: <CA+49okpy=FUsZpc-WcBG9tMUwzgP7MYNuPPKN22BR=dq3HQ9tA@mail.gmail.com>
From:   Shawn Landden <slandden@gmail.com>
Date:   Sun, 12 May 2019 09:56:47 -0500
Message-ID: <CA+49okq7+G7wRgr4N8QLMf-6pvqvYumMQzX6qrvp-qQQsRsGHQ@mail.gmail.com>
Subject: COW in XArray
To:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willy,

I am trying to implement epochs for pids. For this I need to allow
radix tree operations to be specified COW (deletion does not need to
change). Radix
trees look like they are under alot of work by you, so how can I best
get this feature, and have some code I can work with to write my
feature?

-Shawn Landden
