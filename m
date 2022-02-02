Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EA4A7B11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 23:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbiBBWY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 17:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiBBWY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 17:24:27 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A69C061714;
        Wed,  2 Feb 2022 14:24:27 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i62so3079249ybg.5;
        Wed, 02 Feb 2022 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=USlTHjBdsrPjsN1vZ5Na+3QSmX9cMDg+jFsMGsuMEDY=;
        b=ZT98o/+X6pgPDgfJIhb9uX7JzggRU57P8LqQvIsoEr3gSVgMDeT44AkrUKxxBmnA5M
         OP/firCx5Ok5qUUO0Fn3E66fJyBelyw38kdFHpv0NrOFDY0tj7JCusb0InavUat94GWq
         bGMXsxCw9bFimI46b6aobmaiXiNr0pdZ7cP6dssSOVK3DpA44Rrun9BC/5FBsVo+eNO/
         tm8sT9VsD5FQwqMwJEkyyVkZOLCGnB9fwq2N6iu/zTaBQc8PmoT30uBJzmzXxlwuz29w
         3uJ43wW5lb6WpprsB/NSShg7Yh8ymvu4KN+KPlrE/emB9Mh5Af02HwHDG/OE94qxdztk
         di0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=USlTHjBdsrPjsN1vZ5Na+3QSmX9cMDg+jFsMGsuMEDY=;
        b=mV2EnZKYPJnoabsm14IlbCIMD9K4ROAmEibUu+QCfrbEbPPV5i6K1pCR3t2WyZDoGK
         A/zSNaeepYjIPbbrraPcQpfdWiP9zBXXptyiP67XpuG+y3OeG5Ez9uSZCnyKD3vfVWxu
         OhVHfdQ3Ysn2KEWLZs1jFTVkUqV6XIZ/yk36GvSiqtSep/0IQeawWylQ+AKyPugeUGMW
         w2tEKOzv1IWGoK9lBblnzaBNCmr1LeXvxTXVCKRL4woSm2FibnDbI6tFkGIR66rcrUVL
         7EZ38sjVqvjGcLhUWZXuagca0rdL55VGA/RHZAUK4snMHw2yxtalrrXiGHVbBndlbd9R
         /DGw==
X-Gm-Message-State: AOAM532WyRXiRGHMQzk78bVt4UjlwwWrBbdLoUn33w6GpmMyU0rFB1R6
        Ifl3AYCFAvOq4aPjPAFT+E42BhQdB5ZREie0yPPAjc/t
X-Google-Smtp-Source: ABdhPJzgf6y4yKYdFoMPwLWhc8HDueL7x9YUgq23ObU6cEFrXmEjYQw8x/4BG5zoyzRyi9Bczlc6vCOuvK762WMCia4=
X-Received: by 2002:a25:bd2:: with SMTP id 201mr45021136ybl.83.1643840667031;
 Wed, 02 Feb 2022 14:24:27 -0800 (PST)
MIME-Version: 1.0
References: <CAGypqWxPnYx1PwhCQcyb7LLAB0JPsK2kmPWcrmx98Cs0As1y7A@mail.gmail.com>
In-Reply-To: <CAGypqWxPnYx1PwhCQcyb7LLAB0JPsK2kmPWcrmx98Cs0As1y7A@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Thu, 3 Feb 2022 08:24:15 +1000
Message-ID: <CAN05THRxUMdURpyi1XCX_o4f8QZB2ssTZyS-TPKfsgLu7-2AjA@mail.gmail.com>
Subject: Re: Mapping between EHOSTDOWN to EACCESS in cifs
To:     Bharath SM <bharathsm.hsk@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:17 AM Bharath SM <bharathsm.hsk@gmail.com> wrote:
>
> Hi Team,
>
> I came across the following behavior case of CIFS session setup failures.
> CIFS returns "EHOSTDOWN" to userspace when it fails to reconnect while
> doing session setup because of change in password or change in ACL's.
> Should we instead replace it with EACCESS for these special cases.?

Possibly but not sure.

When it comes to changed password, or situations where the user
account no longer even exists
(we can not distinguish between these two conditions from the server
status code)
I think EHOSTDOWN is valid to return as SessionSetup failures are
about connectivity and/or authentication failures and not
about access control.

I.e. it is not access control that caused the reconnect to fail. It is
authentication that failed.

Thus I think:
EHOSTDOWN as "can not connect to the server"
EACCESS as "am not allowed to access the share"

>
> I would also like to understand the implications of mapping EHOSTDOWN
> to EACCESS at the user space for the above mentioned case and how it
> is done in other file systems.?
> Can you please share your comments/thoughts on this.?

I don't think userspace should do this kind of remapping.
Inability to connect to the server and not being allowed to access a
share should
 be treated as two distinct failures in the application, if not for
allowing the application
to decide how to recover at least to let it log an errno value that
could hint about the issue.

>
> Thanks,
> Bharath
