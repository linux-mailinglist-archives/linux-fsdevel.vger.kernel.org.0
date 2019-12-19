Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC2126C3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 20:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfLSTC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 14:02:29 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47257 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbfLSSt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:29 -0500
Received: by mail-qt1-f201.google.com with SMTP id x8so4273979qtq.14
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2019 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QvAStn8TBlGPLBczTd25Iv1mJFk80FYATk+vMJdp0y4=;
        b=CzwiUU2ZMCKcLRSu8XQzid0mJM78vsAjP8tuqj0HQuCCmaASulyFwyNDJlWGoosroj
         1fO4Wsaycbb3TicTzXWqFtSTqPoPoQOm26MamsOm4rg+esbFEOwyWlE6IV14U8O5Wg10
         PQyGxDvrxQ1EbcJD21HPrL6wSCYqbpnFGOIv0SBuo2QZgvuD4KpgNKTdgUZ3SnQ8Wd8r
         /gRd8R7oRg1ZmgfxBWtzuhIJJmWzYKEha1r6aJeZho6rnSfDBRoDGH/WzXFSalQ0XCho
         mHFn2l3155HhsgpwCqyyxeSM852qC9D3IOYqQO9YE8ob5K78vAlpDct/eM67LDYDBjRu
         pjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QvAStn8TBlGPLBczTd25Iv1mJFk80FYATk+vMJdp0y4=;
        b=qTeJ2YvPD4fgQL8NeyP97buqfRZ/WtRlGL76lxnbZEwrd/LI9xQ3lNMBG+27Xmwqk6
         QiQnwn8BFyFGYPg5T7/J5hyja8UG2b+Zciro7cxVwYyO6eDTwHhFRj/JG44sTjZ3H5Iv
         Q/QB9ydPEe1JcoQ67iM+M6lybFtpAHXESe1CBUy2cQps5/0uQRxbgjXPcK7uu1eTkxUT
         eVsgibT0D+8aanZVXrvlWyjL9tHSDYCDs2n4lW0C6iFrqeH8vzIkJWA1rGxSuDMFCGaW
         Sm0aqkzqU/M//WXU8pGyeJ9NoD+iS6ZV9lMNZB3L9CEW+lIPrY1RNEcymI5Z4elAkg/s
         +BDA==
X-Gm-Message-State: APjAAAUjN6DdKq+3PTCqbmLmn8YcFKgcwa660y022roVIASzcGgiZOvV
        FMMIARe9qzwGmgPr7e/3mJxcYgBfIzfaD/W56J4=
X-Google-Smtp-Source: APXvYqxBHQnZ8CGo+nTRD2vQCKeO9gRgt8lGBRpC+p78kO93i8LDJrJzcWT7w8MJOaC0ABK7FXngW9PNnyvbNdWs5Do=
X-Received: by 2002:ae9:e304:: with SMTP id v4mr9534945qkf.399.1576781368073;
 Thu, 19 Dec 2019 10:49:28 -0800 (PST)
Date:   Thu, 19 Dec 2019 10:49:24 -0800
In-Reply-To: <20190808123942.19592-1-dsterba@suse.com>
Message-Id: <20191219184924.105306-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190808123942.19592-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH RESEND] fs: use UB-safe check for signed addition overflow
 in remap_verify_area
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     dsterba@suse.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, natechancellor@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yeah, looks like this kills two birds with one stone; both observed signed
integer overflow and -Wmisleading-indentation.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
