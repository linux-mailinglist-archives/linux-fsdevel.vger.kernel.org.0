Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6388EAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfHJWZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 18:25:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40736 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHJWZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 18:25:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id h8so11612537edv.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Aug 2019 15:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KRtP4QuyzaZWmXH4GaNoyiAd8Ahqe08vgZLgai8zw98=;
        b=pF1W0/kY1vYaYCO9Bh18LQPARJHzBzyarAYlOxer3c5nrRMgI9pNZ0FKnjPnd2ZeVM
         9D+w6Oerk29Laj/1I4P1FhSGuf7hawrb9DSaZ9GceGTH5tCZ+Wr2A4C1DZXoJXek8Fwn
         REgnrW7QEghGHKT1T9WrZ3/I44dn1jmhOCEHl2AU6EN6gWNTjFBuXPIV2v0BDGh0RBod
         krSggHzf2ABlb8MF4ZMO5PkdS/BFkyUEjRwzsBY5yJafhpVCofcKzevBtq4OH3Rk31se
         R5I4kdkyMD3FFEniRD/CWY28UAsn6yIp4xUj+KJPLwnDRN0GXZnsI0tPpxRTRxZeYKVu
         KEPw==
X-Gm-Message-State: APjAAAW3MP+mERDDTAeE+CBmLJCZTD+jdTTlqiJE4L6QqJY+J8z49U75
        kWOcO7ozr2DnAQbkkoo918CrN/vYyxU=
X-Google-Smtp-Source: APXvYqwwf5XSrxiotZmJAeD9YX8rgkzVCPMOyWJUS12babQ2aibgSQnt5KWUOlLDf+f8gaHZcst6pA==
X-Received: by 2002:a50:94f5:: with SMTP id t50mr28937530eda.150.1565475904545;
        Sat, 10 Aug 2019 15:25:04 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s47sm23348433edd.40.2019.08.10.15.25.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 15:25:03 -0700 (PDT)
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Merging virtualbox shared-folder VFS driver through drivers/staging?
Message-ID: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
Date:   Sun, 11 Aug 2019 00:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

I've been trying to get the vboxsf fs code upstream for 1.5 years now,
it seems (to me) that the main problem is that no-one has time to
review it. You're reviewed it a couple of times and David Howells
has reviewed it 2 times. Al reviews have lead to various improvments
and have definitely been useful, so thank you for that.

But ATM, since posting v12 of the patch, it has again been quiet for
2 months again. Since this driver is already being used as addon /
our of tree driver by various distros, I would really like to get it
into mainline, to make live easier for distros and to make sure that
they use the latest version.

Since I do not see the lack of reviewing capacity problem get solved
anytime soon, I was wondering if you are ok with putting the code
in drivers/staging/vboxsf for now, until someone can review it and ack it
for moving over to sf/vboxsf ?

Regards,

Hans

