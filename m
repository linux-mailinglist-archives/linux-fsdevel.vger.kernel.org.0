Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADBA172957
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 21:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgB0UPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 15:15:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44071 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0UPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:15:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so304831wrx.11;
        Thu, 27 Feb 2020 12:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J33BqWoSd9tEESJbD+stgo5KGtSSLbabOsGpVtJHHtw=;
        b=bquWi+8fZQ/VDIaFczUAc6iR3pFqrtHFrYnukMwaqrYXmPWKS3GTtlWh/1V4jC1fYV
         ir/8z0OHm/dDCckFyGKKwRJiEPAfY3nrpUGDOjA2dlgrgrbv+1BrA+392sHwCPPtV7IN
         MaDYQ23bZxby7CyhuM+wiR5c5QJIlgZ1yvC8eQILqYIu41AIMZpPzhEczOKLWsbxCmbl
         uqORjVMnljGGEtv8D28SOuISWjG1S4e4PuZq4nPo/vtHUzW6eIRHx3J1/VgJBt0cZTvV
         M3Zh90rSgh4d8rHnwgQ+bCDR1Lo9ePuR8STibjpeV+9NQcdWWb45x7hJhUH9MBB6hPQ7
         z8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J33BqWoSd9tEESJbD+stgo5KGtSSLbabOsGpVtJHHtw=;
        b=cTLEQ0QP0SggpGFzk+GiF0oQcx0U3J4pbVDR2nk79IiRKPorHbUmxc8TVuioP/vw8w
         ibvbqmpZuS2oFKjKMvbGrIn1lA9mZ/gmJ5MBLtrJAnwlvxhvw0wnuNTBIAUYpr7FiUCe
         cgIhp1S7+eYhrMNb5GYYl07rGbyYcpelSeNPWXu0ccusNcW+s4Z1Rhg0ZC0DelxS2mhg
         ORxmOfAcCxyMOnxMsE174mKy6/14zNgrcpN3mDl/tVng/H8Qzzv1KsZIOP/3EdlNgoC7
         xRM5HrLQZRiHlkBCzXVmFbXgs+HgMUNUKDDqKAZip6b9OLMek+/22dsNt2WgtSM/MG0b
         WroA==
X-Gm-Message-State: APjAAAUlUVz8S6f6zxn5Z7ikSPA8gixdXfQMNR+kgoyCQjJ3smt5WGlT
        rhuWOHI2touSPDj1SkjHAw==
X-Google-Smtp-Source: APXvYqzFpxNj+R6EzLNVlCdpbjMBg67JDbaynrge1wTN5MEP/xYCmS6Ep6ClwVxwd9grDIWQ7XLKXw==
X-Received: by 2002:a5d:534c:: with SMTP id t12mr609954wrv.105.1582834541724;
        Thu, 27 Feb 2020 12:15:41 -0800 (PST)
Received: from avx2 ([46.53.254.180])
        by smtp.gmail.com with ESMTPSA id s139sm9380007wme.35.2020.02.27.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 12:15:40 -0800 (PST)
Date:   Thu, 27 Feb 2020 23:15:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jbi.octave@gmail.com
Subject: [PATCH] proc: annotate close_pdeo() for sparse
Message-ID: <20200227201538.GA30462@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Fix sparse locking imbalance warning:

	warning: context imbalance in close_pdeo() - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c | 1 +
 1 file changed, 1 insertion(+)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -139,6 +139,7 @@ static void unuse_pde(struct proc_dir_entry *pde)
 
 /* pde is locked on entry, unlocked on exit */
 static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
+	__releases(&pde->pde_unload_lock)
 {
 	/*
 	 * close() (proc_reg_release()) can't delete an entry and proceed:
