Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0CB95E83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfHTM2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 08:28:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36712 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfHTM2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:28:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so2496136wme.1;
        Tue, 20 Aug 2019 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSR8sb1uotjnjfdOyV2jp4tciGn/c2mOxbn+GtlfYOs=;
        b=Sb8IcfXuDfRdmyL0CRWnFamS5vXoAjqTViv3zIBCL7F76sefcdcrviBEAfc8hUN6mY
         3T2bTygs2djOmtPhghEO8PRH2iKMYaNCw9HCKu3MztXx0199Y3m3lZm7qg1ygnF5ZipV
         9zTNPxjLh3mxv/gSW7AFCAFg96NijzXXkpMMfyZz9iK9Gu8BRzkt5jsP6rSh45v6mZaD
         1Mp00pCMqRSNjKv24+RZJwwcK2onM8os9c3AzSupDq/Y6Tuboo7p5U9mMSviFfCMGbyH
         4/mgJa/JCVh7gCKrE/mr+4oGqLmlc/13oohkYaUKNtCUmwcT0ufYIDDwRe4pOWb9o4KN
         lcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSR8sb1uotjnjfdOyV2jp4tciGn/c2mOxbn+GtlfYOs=;
        b=FaMCm9tr2jksjCKWASEHmgRjWJ6XAE1RI0zxJp/GHsPdP4OhGFrGg38qam+hnNiuFZ
         Kkx/LAWajyEL/QACoibwbQbhPZKF9PsR0yTzx3s9evK1c9wSz/s07TNHoNPVHON3dIrO
         XQaet/EcnUPlVdCoktN8EjUAy+OGuYSKblikpQYRWIh5rjeJMMLcGjes6qWTUAPZTdx+
         +02wCCingD+LaUTrzTbQ6XGvk1qwdlKveefr2noa8fu9YLn5/I1mEp7OyitaDKRR2y3i
         JvTbq8zf/ZIX/1SH6wEs1MJKa/ZkwsJ49NCIafYVMQU2poQ4jv4ek+T9xZgEh+O466c7
         DSEw==
X-Gm-Message-State: APjAAAUX53w8VbFdei8PAuQEJ/6cAnPB9JHbAIcSXg6NN/SL09kmh5g4
        /eJbzBw9qXfboHUzHuS2ItmeQUMP6KCQHLe0RFrBmMcc
X-Google-Smtp-Source: APXvYqyRVbaXH5E+zsLwPDG0vuC0U7wlFSG7bKGWfN7PgLa4N/DQBhMBCHvfrfvM80hn+6Il6g7uH/noqPunFBw5Yzk=
X-Received: by 2002:a1c:dd8a:: with SMTP id u132mr498571wmg.1.1566304123445;
 Tue, 20 Aug 2019 05:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
 <20190818165817.32634-7-deepa.kernel@gmail.com> <CAK+_RLmK0Vy79giAZnUCmmivvRT+GLZXyiMqBoFB0_Ed1W8BkA@mail.gmail.com>
In-Reply-To: <CAK+_RLmK0Vy79giAZnUCmmivvRT+GLZXyiMqBoFB0_Ed1W8BkA@mail.gmail.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Tue, 20 Aug 2019 13:28:32 +0100
Message-ID: <CAK+_RL=ZK40XWY_c8wskAwNw8-Q3DY-+B0GoYo0JEVmqxYD7ig@mail.gmail.com>
Subject: Re: [PATCH v8 06/20] fs: Fill in max and min timestamps in superblock
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        reiserfs-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I see no problems for BFS.
Acked-By: Tigran Aivazian <aivazian.tigran@gmail.com>
