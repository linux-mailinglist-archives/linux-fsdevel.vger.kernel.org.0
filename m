Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777B345A54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfFNKZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 06:25:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35917 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfFNKZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:25:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so1965938wrs.3;
        Fri, 14 Jun 2019 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ks/1jmSJKxs1ncmSkAMP0ItIlKw6T3TzRE1qoFw+E5A=;
        b=kUWroVeijDm9bzhzpUxRfZ9hMYQNn9eQmH0tUmSV0w4DdYwIQO4aRCNkpCV+BNvsjM
         UGZwOZPI7w6O/djb/LQhKUA7ytP1rQh4txH4CXHfYlC26ORkZ7mI1FVnll/V1XqlGRYN
         RYYzFWy+6okKYFEPEaNo4lh4kRhcZ87DHVzhCpKBOULqKUHvEKWwkFPPk75OFDpNduJw
         WNm0EsFzGjGtsfC927hae9qNzFF8JWLse13MaqY4dUaDSBZqn5Q7yQzf6imoPTIbL+S8
         RPUVppPqn9xKPIqkSfueducS1qAkhNzfNrcXoKOjn+JRJbUZii+fjGcTpe7vhyhmuXQo
         qb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ks/1jmSJKxs1ncmSkAMP0ItIlKw6T3TzRE1qoFw+E5A=;
        b=XUyosOT5Z01i9rr6NDjjzEAl9GviI+WABOySidDUIS5ueW52DfBgJRU9ztgj13lQRu
         6h0h6ylQnH7avXls4SuWXTn6wvblXG5dqcN7xtntld+poX9yNkhgseoj/IklppSHbado
         n3gNFaVUfjY4J7a/s4ktEhR+Cd1PZ6g42ArwQ5kb3/fClH/h6hXceUdJDHP7eBOa6ZMw
         xoFwYIPS2w8KZvT8oxDB4eEPQufVf9gwHA9k1KIZSfY6IefJsJVtEF3RCYAwQL1EGKh4
         YN0Dtm3oVmdQbcXG0RAikWS1gZVBKo1Z7bpS5GHlUbV/L03QEsroUR5Xk0EbcQo6WpX3
         yqvw==
X-Gm-Message-State: APjAAAU3Ia81eO1QaXGeEkeMdHAuwNIT9a/Cc0fqtAp3hnAe7uT2CVOF
        aaciU75gnNbz5PhVhgoswA5/V7vSLgU=
X-Google-Smtp-Source: APXvYqw9EmKo3dJlol+Y0ztB7t3zpQOt4EXb0zFFriuCw5GQUPRN4U272roZb63DjFCDr5xtonwoIw==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr20904700wrg.39.1560507915517;
        Fri, 14 Jun 2019 03:25:15 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u23sm1766697wmj.33.2019.06.14.03.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 03:25:14 -0700 (PDT)
Date:   Fri, 14 Jun 2019 12:25:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Help with reviewing dosfstools patches
Message-ID: <20190614102513.4uwsu2wkigg3pimq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

Can somebody help with reviewing existing patches / pull requests for
dosfstools project? https://github.com/dosfstools/dosfstools/pulls

Dosfstools contains linux userspace utilities for FAT file filesystems,
including mkfs and fsck. They are de-facto standard tools available in
any linux distribution supporting FAT file systems.

There are more patches for these utilities and due to lack of more
active developers, these patches are just waiting for review.

More end users are asking for releasing a new version of dosfstools
including of those waiting patches. So can somebody help with reviewing
them?

-- 
Pali Rohár
pali.rohar@gmail.com
