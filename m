Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBB3043BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405356AbhAZQYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 11:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405245AbhAZQXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:23:55 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7117CC0613D6;
        Tue, 26 Jan 2021 08:23:15 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id y14so4248875oom.10;
        Tue, 26 Jan 2021 08:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=J+/IV7fLyvRi0Gt1MbI7WhOSaH8Ca59YsppULIcIKVM=;
        b=nBgkFZFfEbmWOiJaMq7wZMJRDatIglHTc98cPF1PLypSZlI1IvLQ94zGOuOpAEMH5J
         TGTx7ERjnX6wfmw5WfWfLJGGs2vZI2FtL/Hz23/tDi8W7qtRPFvWlBB63Qa9fpNSIafz
         8i1Ch98kvbdKhcpGw8F3kif69ybA8TiDpFXNDhepQmrYxzHnRSht83gZj5ajizo/WlCT
         +sahKVJaVJdlzGnYB4XT5qoFyN5yzLQmWzKqMo5kzeGHmn4fUVPVzhABdCVr1XestXsb
         aqpGsODeYbvg7T7MFqKbQNV+S3hV010ov33I/a3YXGFcFneDIWga6Y+LwClCbQLBmmV1
         dQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J+/IV7fLyvRi0Gt1MbI7WhOSaH8Ca59YsppULIcIKVM=;
        b=sY8FcPLRnXo5Yiyhl0DuXwGna2jQYuZnb2i2i2T4Fqgdx0vxTLgG39bnkegtB0mU7f
         gCTtce61IbmMxxBcHb+rMVdbAkfhF/2WyKGZZKcmBQ9XI92x9R9sJUm/uEFeqxvGmkFO
         9IDRcUUQGUbarbPA1pIIrCYal9ZcUEDZQA1msX85d9omyuK697tel7NKEVmYXd2D2+fG
         kzAaMZq/pdVJi00D+Z5hXBFzyUp7sL6QLTfnStVxwRgBnKhjEiF2/9T27E2Ilp11+jPR
         /Fw7ndMAJ9VCNQT4WkbWUTFwqBxlNEhltp4BMGWZiLp/b/0jmsMCbHPoRqFpkA8/g1XM
         hEnw==
X-Gm-Message-State: AOAM531C8e20BIgGcREWlOZfwKiJO8f4C86L50Gx+gNnci2/qIlQo7vQ
        ytCS2pZRUfXtgPprVqfXiD3CcyREBKMJdWlRwRpjgI6RGA4=
X-Google-Smtp-Source: ABdhPJyxzb3cji/OISfGzdZoidztFfEevskuLisITco63Lq0hY6xzZYf9OIO2BdfFkYIn7gBv6JjL1zm9Z/hRdxbiLc=
X-Received: by 2002:a4a:ea88:: with SMTP id r8mr4499991ooh.4.1611678194761;
 Tue, 26 Jan 2021 08:23:14 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 26 Jan 2021 08:23:03 -0800
Message-ID: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
Subject: Getting a new fs in the kernel
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kernel development newcomer here. I've begun creating a concept for a
new filesystem, and ideally once it's completed, rich, and stable I'd
try to get it into the kernel.

What would be the process for this? I'd assume a patch sequence, but
they'd all be dependent on each other, and sending in tons of
dependent patches doesn't sound like a great idea. I've seen requests
for pulls, but since I'm new here I don't really know what to do.

Thank you for guidance!

Best regards,
Amy Parker
she/her/hers
