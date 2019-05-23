Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9445B285C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 20:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfEWSV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 14:21:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37989 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbfEWSV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 14:21:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so7324418wrs.5;
        Thu, 23 May 2019 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qEk0GS4FXU16v/PK8eee13x88Us6k5oXp2zq/Nd4me0=;
        b=vGg0mfIrIu1QIFKMxEH6OB8L7+xDFF+s0o60XTox3LKUX3+5OVaPxZpP/oqDGzryJc
         vI7t72/NMZVKPg7LeuNbtLbkGGOXecCeui6yGY0+F7UmqwWCS6ASFIBZYvjeUdtDs7ZK
         t4xwbJUS1aApbMwmj+0zIB4XsgM88LRBkpCcjW5tbxtuAHl9N8062HkVAPcGh5d73L9g
         lAheQifG2mr2SytlzQKcM0OUzgFxq2zGI+DOMh+BflHaJS/sBb3NetoSSJSbevXtEDp4
         fj+IIBNjF0qw9j4mQ0W7jlxOfi8W3sXxR+tWKvMQNO17Xdy0vM6BfW/aDM5JRhj3iPZw
         fPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qEk0GS4FXU16v/PK8eee13x88Us6k5oXp2zq/Nd4me0=;
        b=IncBA2KnSOLfFRAQriF05fz/sLbqtex9FsSg3DwVXl9lUk2k9z5T3vitjVUfmarTG7
         JxFKyrGUx6jF3OBMRtDoamXqhUAK1l4defZ6iqfiUnv/veRiWeUXg2aZGXsuPTpJWhwW
         CKXIE5Nk92mO8cla6rKWzo3mra/u0+e01UHtkpqhHc6REzgvDw4UbC5dqg9aXgEng4Vl
         ZRH4+O4riYbMjt5E0f5PDNPNc4gPrEsos7D7FNL3yJdza2qYA1Vtak/P63G14t6V9the
         +0Wtsqj/da70Mr1re5i9+ynGshWIDQk6pih+lUcQrkzkZapcS/daaOvNra6aA2+12vh5
         pNeA==
X-Gm-Message-State: APjAAAXMXOaBtWRGtkjSPrgXVO7OnnQdnHe13JG01cIJWhqRama5pG83
        0qcbCA11ITEqLAvjGFAVJrTt+sc=
X-Google-Smtp-Source: APXvYqzp/dIg1ag8A/2uxeqIaj7tjPL/nDS4pJP8G3jPotwtjtqJQjc8kp3hm7vSTnMfZYlRbh/45A==
X-Received: by 2002:adf:8307:: with SMTP id 7mr49716836wrd.86.1558635715290;
        Thu, 23 May 2019 11:21:55 -0700 (PDT)
Received: from avx2 ([46.53.252.55])
        by smtp.gmail.com with ESMTPSA id a14sm21689wrv.3.2019.05.23.11.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:21:54 -0700 (PDT)
Date:   Thu, 23 May 2019 21:21:52 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] close_range()
Message-ID: <20190523182152.GA6875@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This is v2 of this patchset.

We've sent fdmap(2) back in the day:
https://marc.info/?l=linux-kernel&m=150628359803324&w=4

It can do everything close_range() does and potentially more.

If people ask for it I can rebase it and resend.

P.S.: you are 2 steps behind :-)
https://lwn.net/Articles/490224/
