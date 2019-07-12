Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4961F673FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 19:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGLRKT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 13:10:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLRKS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:10:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so4574886pfl.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUouZ278xjvsvC4w+tnk5XTto+V/LoTNYV1OchFqbmk=;
        b=Rz+g0/dLCdbO06heHUbqXyGSsACW+J67TcAEQQdtnr0VhN5rPxOwnFr4ATgn44owID
         ZwGRm6KHmcMO8T1Uirg6jLVFt27Yd+zbjSOLLoi/Y7L6OcRbKsQdUVeWCHZxJwOjQV8m
         HqK68saAs7KfCxj8uHcCBG0OvEL6Qr4yi4UDkU8lSXrHBQdDI/lapCQ+/421d6M9tomo
         kmJ33IvrsxZ+wCoHq4o5EM/ndyllTdZKEanoMRzvxXAwdwESViiJcSDDKeTcbxZG7DYp
         SEyDKvJbL6pY+wAyErgmUx2TbzHffAmreg5PE0aSdbk1hUWLmpzbCr1BXRnkJgB/I5lI
         HsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUouZ278xjvsvC4w+tnk5XTto+V/LoTNYV1OchFqbmk=;
        b=alsZ2vrVD7mCuevY6XYn2RT4d03ORPc3cnlkCIpOV0DuLDOn4Wu6+BmJx69e5qyJ8e
         8XUDcxNCOJ8jZx8jWaPsQ39qwA8LxMtN7DhHUYKm3lv7L5V24rUUABkCpAdzgp3fz620
         8dXCW0EIJPsC/QfnzM+SG/Da7XPRtx6nXrpCw5POV8yioosQ5Dp5RnSiTedUzvPGF96H
         Ll5RM1QjHumjMTb27nMkmwMFCJSOAlMYwnlcHcX4CE8/b6i62MQVS2hUkxyIqCRT1aMz
         /gEN0rFqRetYjfGU4T5jepqAppskvglVvKKoq6OKb82yhsNWNoy0nK/STEyxEicN30jS
         NvrQ==
X-Gm-Message-State: APjAAAWt/udMKchv0WbnlO4cooayOU7z+OvdScyTUrK5WdVTKmlkNXzW
        VO74NQUgQQarRnsAD08hwaiXXn/k
X-Google-Smtp-Source: APXvYqw4dQ5lNDKzXuqqp042omvR7OnRMrbUos8BXlNTuvmuOczEcFcKvXADJlWbC5E+tkMI0yzODQ==
X-Received: by 2002:a17:90a:77c5:: with SMTP id e5mr11675919pjs.109.1562951417970;
        Fri, 12 Jul 2019 10:10:17 -0700 (PDT)
Received: from [192.168.1.136] (c-67-169-41-205.hsd1.ca.comcast.net. [67.169.41.205])
        by smtp.gmail.com with ESMTPSA id e11sm11038377pfm.35.2019.07.12.10.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 10:10:17 -0700 (PDT)
Message-ID: <1562951415.2741.18.camel@dubeyko.com>
Subject: Re: [PATCH RFC] fs: New zonefs file system
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>
Date:   Fri, 12 Jul 2019 10:10:15 -0700
In-Reply-To: <20190712030017.14321-1-damien.lemoal@wdc.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-07-12 at 12:00 +0900, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned
> block device as a file. This is intended to simplify implementation 

As far as I can see, a zone usually is pretty big in size (for example,
256MB). But [1, 2] showed that about 60% of files on a file system
volume has size about 4KB - 128KB. Also [3] showed that modern
application uses a very complex files' structures that are updated in
random order. Moreover, [4] showed that 90% of all files are not used
after initial creation, those that are used are normally short-lived,
and that if a file is not used in some manner the day after it is
created, it will probably never be used; 1% of all files are used
daily.

It sounds for me that mostly this approach will lead to waste of zones'
space. Also, the necessity to update data of the same file will be
resulted in frequent moving of files' data from one zone to another
one. If we are talking about SSDs then it sounds like quick and easy
way to kill this device fast.

Do you have in mind some special use-case?

Thanks,
Viacheslav Dubeyko.


[1] Agrawal, et al., “A Five-Year Study of File-System Metadata,” ACM
Transactions on Storage (TOS), vol. 3 Issue 3, Oct. 2007, Article No.
9.
[2] Douceur, et al., “A Large-Scale Study of File-System Contents,”
SIGMETRICS '99 Proceedings of the 1999 ACM SIGMETRICS international
conference on Measurement and modeling of computer systems, pp. 59-70,
May 1-4, 1999.
[3] Tyler Harter, Chris Dragga, Michael Vaughn, Andrea C. Arpaci-
Dusseau, and Remzi H. Arpaci-Dusseau, “A file is not a file:
understanding the I/O behavior of Apple desktop applications.” In
Proceedings of the Twenty-Third ACM Symposium on Operating Systems
Principles (SOSP '11). ACM, New York, NY, USA, 71-83.
[4] Tim Gibson, Ethan L. Miller, Darrell D. E. Long, “Long-term File
Activity and Inter-Reference Patterns.”

