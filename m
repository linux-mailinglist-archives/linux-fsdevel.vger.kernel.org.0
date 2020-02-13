Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2915C034
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 15:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgBMOUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 09:20:19 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40440 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbgBMOUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:20:18 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so4396317lfi.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 06:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBiaO6Z8OBmXQcABzLnfKyWv3cIy5alz8cnxEzNjtnk=;
        b=O7NYbtAtK8LzZTWMHKsDcBd21xqNpTctsP6CRV1DcAzf5bC+dXiydmb5KkVi3OE4RR
         WqP8NJ6260X7tiFImoZiyeAqz9qcs0hOahNt5wxNKVcrIu6XOj/f8brn3JJk2MH9AB11
         ki+hOnpu0OGAyrmu7KD6ZeI8bfGrdQCn5WLddFZHydDfX1jAFHzNbvjGWo6RYkcywHs6
         C8cvuBnWk9NEbGgHXwl3L8qnQZKIE3PpuHMhkKxittZ/d4eseD0Avbz+pb1SXbtmJIUL
         uDeEuje9rCOamWfbcnIWcxXVHwUFjqqlvr7zB5m6DYSbTwxoRH24qgku86HWLHZrZ68n
         Pb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBiaO6Z8OBmXQcABzLnfKyWv3cIy5alz8cnxEzNjtnk=;
        b=NKlTQs3HMy2Sd5P7Tj4N5jAV6yhe088zBo8+X7AlBQXQ+Fh/CD9wtpWpYdcCeVYPWY
         4MXgldiLtgiDJ8+WKk40NWo2PAUM30Ux76XP4dip1smzrknTgepoaKpgUq9lr1D1wjTh
         PQtjIhI5a8E6+nFDF1w35aCcWqldVHCcAH9GcThRLLCj+U2w2fnoAR7zWDXxVQHlJOR6
         ipfRbMVMo1Dlz5G8zPt8JQNalr/J9dZB3oVe8nlzVR5Hfp2d3ZAToZ2AwK/7dFrh9hdo
         qI2YjooH5Xl0hStdN2+5j04WZMKCJFkFaD6TKx4Nb58nzsVG3H/kPT6KwVc5//actEAb
         u3Sg==
X-Gm-Message-State: APjAAAWeU9up6r3z3VWeyWJDEIuGPPrd4Kq+m0EQ8t3t5IZC2fwPJ1SQ
        YxqRm4eBCjdg54np1JbUmfLqWg==
X-Google-Smtp-Source: APXvYqxdpoct14tGY982jvV4dtpFV6Kly3+FzM3JW5XMXYar2aNa2FtjEVnYdZDlvQBiykpOS2jHVQ==
X-Received: by 2002:a19:8b89:: with SMTP id n131mr9639128lfd.14.1581603616192;
        Thu, 13 Feb 2020 06:20:16 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l3sm1552335lja.78.2020.02.13.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 06:20:15 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 79429100F25; Thu, 13 Feb 2020 17:20:37 +0300 (+03)
Date:   Thu, 13 Feb 2020 17:20:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/25] mm: Introduce thp_order
Message-ID: <20200213142037.e2yi3gdn4url7zlj@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-9-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:28PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Like compound_order() except 0 when THP is disabled.

Again, functions are preferred if an option.

-- 
 Kirill A. Shutemov
