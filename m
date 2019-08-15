Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213008EE54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfHOOgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 10:36:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55368 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfHOOgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:36:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so1463150wmf.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 07:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hSLhcEGooqDQX9dEQ2Iz0HJ2gdxioh+I0vkr5E0xYqM=;
        b=Op0CYTScdT5y2Go4yJpDYkwCh2oerAW3awhtaq08T0FZJJKuIOthY9ulfwSlR9hsop
         ZdpFnmxUVca0sRSJrVdUW4vuK7QlZ0qfCpMQpR0Gjz9y3mHd6oTMgHrnpZh/bLFzLTrj
         0yqSQF5tZxsomsuHXqnvw2AwYUNzEByG93zm5VtKpGbH+YdmrGkBhCsAObH0zuTE1vml
         4jvBXKB/BVhTp33sQYpMH9Tly6QMbDzOwk3BKeMjQL52ztes09inZyfxFJz/aNFFWiSL
         lmV+vRU+CgGZ4DZ4YYhKJaSZVRJuM/JbiTKtUzoOTzdF3AT8KPwGjv3/sCD4ww6iLY/D
         3Eug==
X-Gm-Message-State: APjAAAXhgUjDunZ5bZdxddW/71p8satoSJfCfGqAXspoci4IX+Qj5Skz
        LWubxMxcQyY79Ag1Dqc+9P+osA==
X-Google-Smtp-Source: APXvYqyng1mN/kzWAwo9k6mmDuHmTQzWXNksuIZzAaapJBv9bCyssYPg7CvIns/jwx/W/5N8vovmwg==
X-Received: by 2002:a1c:1a87:: with SMTP id a129mr3024832wma.21.1565879765976;
        Thu, 15 Aug 2019 07:36:05 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y7sm1239152wmm.19.2019.08.15.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:36:04 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Stefan Bader <stefan.bader@canonical.com>,
        Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Brad Figg <brad.figg@canonical.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH 0/1] Small potential fix for shiftfs
Date:   Thu, 15 Aug 2019 16:36:02 +0200
Message-Id: <20190815143603.17127-1-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey, people.

I was lurking at shiftfs just out of curiosity and managed to bump into
a compiler warning that is (as I suppose) easily fixed by the subsequent
patch.

Feel free to drag this into your Ubuntu tree if needed. I haven't played
with it yet, just compiling (because I'm looking for something that is
bindfs but in-kernel) :).

Oleksandr Natalenko (1):
  shiftfs-5.2: use copy_from_user() correctly

 fs/shiftfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.22.1

