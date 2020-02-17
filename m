Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5973C1607A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 02:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgBQBRH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 20:17:07 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33002 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQBRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:17:07 -0500
Received: by mail-ed1-f53.google.com with SMTP id r21so18746556edq.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Feb 2020 17:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=DnHhz22AIH0I3r0zwR1iymi7Rw5vIKB9LN54cAkIom0=;
        b=JuIMsaKbjkP9PxLgJfMN4gOFXsAS/sIwfk71XlEcmRhX1i27H5Dd4soyrB3ifbftsH
         wEQ+X3gbED1eB68Y3vYbEgX12mZjqLZd100R4KvP+zh7gqhXxFzQD3abhUKuhPzUyNm0
         vip1fq7f6YRW+IE2OT+gIqlHVsv+8YSIveWe3Fbux+wNat/sDCvks9qx1NVm/434/a1/
         SWYFtuwXCxcNViN1QujyuxNxzFkBlf0J23O8AbSPrwlRV7JYOAXlZeAgGFR4litzgluu
         KWfIgZ8p97VTbKdWkkLETb4YRBwOdcHxOZUa2Z+H948fNi8P7tUgBBHmWazam6PFLMei
         6DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DnHhz22AIH0I3r0zwR1iymi7Rw5vIKB9LN54cAkIom0=;
        b=UhkOlbGcMQGVgaVTIjtZVY+DObO1k7t7AAfnCeDzsYnmLkaHE8D2jO/Ar7tsYvgZaX
         xpaA4CAxO5ZbtIDKa18NMUQswWe26xvnNMoMXDZJDzMhuf23MXtPyxZ6c66gcCVufpB9
         6SN9FpfqAfzXTwqdp1Hcb6d/qJEUfeP1IT0MIHDj6elhDLhAoxh4tz1tOXpDZ3ouREtb
         gHg8TZ1D2yoHtWDIex3rSOqpa0N6hKy/0TwcGwWDROjHy06su9blj0fGLuClSZnBz94E
         BT7Ne0S6gI/umcRxmCtdqMLQaPPsYNwUkq+k5O3WOR48xELHOvQmyBU6rBm/vGPOf0L5
         Fo2Q==
X-Gm-Message-State: APjAAAVjIA0aPjfadQvrV3U47NyKBOXd3pfnFXzhgYyCgW6GeEdmSqOg
        XJaP8UGm+B3V2SYs9OucXutL7o1FZIabLhYSwFwx5tYE5Gs=
X-Google-Smtp-Source: APXvYqwegmfuHE42HdYYzw/ZkdgumbxtdOG5yfwgG40/Q8wqOpIoH+aQKLG2G25C96+yWpXid8+YHWRwfgG+OiMFyr0=
X-Received: by 2002:a17:907:2165:: with SMTP id rl5mr12796349ejb.193.1581902224948;
 Sun, 16 Feb 2020 17:17:04 -0800 (PST)
MIME-Version: 1.0
From:   lampahome <pahome.chen@mirlab.org>
Date:   Mon, 17 Feb 2020 09:16:51 +0800
Message-ID: <CAB3eZfuLaKYB4wzaJU6Fmxvg+VJcNav=8Qn_=oPsOSCiJoNhwQ@mail.gmail.com>
Subject: Some language have problems when using case-insensitive ext4 lookup?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I read commits about case-insensitive lookup in ext4, but see some
points make me confused.

Quote:
Although
This implementation is not completely linguistic accurate, because
different languages have conflicting rules,...which brings all sorts
of problems for removable media and for users who use more than one
language.

1. That means it still have some unknown problems when I use language
not english in newest kernel?

2. It compare dentry name by utf8 encoding, so the table in utf8data.h
will grow larger in the future?

3. If I create a invalid name of folder/file in case-insensitive ext4,
what system gonna do? Return error?


I'm a new to ext4 so some points may not describe clearly, thx.
