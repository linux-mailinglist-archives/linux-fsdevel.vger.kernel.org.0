Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00A3582D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0Mq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 08:46:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36223 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0Mq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:46:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so6958976edq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2019 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QcDk5zUKbz23dkSjNBVXwjq0i8xHM9vtNbHjMMC6vV0=;
        b=Ph8a0a5yHbRPhclO3Pn0KnYkbHmqZJ1TzgavGNPl8lmeqhJTJc84xPfvgYwIEtmpAJ
         SLUBBxlcsWcu+FQLeGK2WBfqjvVNdPyCSw5uxBpm/DHLWwg6ht4aR7x0iOdbABcWIihQ
         wRNHBiJrT+zuLgpTm1MbLIaqKSi2JTrCJHxM7CkX09ypWgFJpJ4b4xqX00fWg+NBj175
         V7xJ+dVSS9ieTZq8jeuaAVG7c45OdqBRFsyCmrAD+BAy/yBT2KC/Homx61Vz7PAGYIeL
         7oTqvW3rLlxDu9ZaKffB5hPvoQHEQthc7VBSVJ0OTK1xXMRCB1wzy+2+JrC9R38OptSn
         mGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QcDk5zUKbz23dkSjNBVXwjq0i8xHM9vtNbHjMMC6vV0=;
        b=AngAPMla9gPuaLT48BSdghGml4O8zoGWTnLkNaPJxCgHXjCCrQ+8BMRLlfWgAhJzBI
         jDcHH45q7z6J3Q7aKI/ebQYFHtKANwCUUt0SdDUsSARwi3/O8rDKCupXkqre9qnRJ2UF
         q1fOBpSwgynDNv5qxzJvFJGq/1tphp0VH5iSuMq2qhr22YIq9/tPKgNBcdfQSONMKu78
         IxeB6wTp+RC+4uVjiR14kkuVSvW/erP/fTVrbUmkExk7uoukiq2VnhOwNLto8NHC/vZ7
         kmeIWhrcfP6Nz3OUht09AbRwUVWNrvtiqG0qZ6FQKPr5fhcvD20SA3/poQlyKzuuSOxi
         S2Cw==
X-Gm-Message-State: APjAAAVvF+z7plnyuQeMBeqvYrqc/BSFB8pMgq6aYAk/rskGbYwyNo+u
        yvKgo+9QwI8ZILN8tCgRzedJINinnFk=
X-Google-Smtp-Source: APXvYqx8PviEpESGoaGFrEkuGJDnDhMWSIld5rUq0chtQKwTslTti67hACIPECZQNkq5ZBizPpaPOw==
X-Received: by 2002:a50:976d:: with SMTP id d42mr3969822edb.77.1561639586109;
        Thu, 27 Jun 2019 05:46:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c48sm735496edb.10.2019.06.27.05.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 05:46:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2E04A103F66; Thu, 27 Jun 2019 15:46:24 +0300 (+03)
Date:   Thu, 27 Jun 2019 15:46:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 0/6] Enable THP for text section of non-shmem files
Message-ID: <20190627124624.uzu5trpfcdcz5uzz@box>
References: <20190625001246.685563-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-1-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:40PM -0700, Song Liu wrote:
> Please share your comments and suggestions on this.

Looks like a great first step to THP in page cache. Thanks!

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

THP allocation in the fault path and write support are next goals.

-- 
 Kirill A. Shutemov
