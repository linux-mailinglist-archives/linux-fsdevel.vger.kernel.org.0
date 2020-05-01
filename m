Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03431C10F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 12:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgEAKlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 06:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728119AbgEAKlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 06:41:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7361C08E859;
        Fri,  1 May 2020 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nMHTHopnpI53GREMKbZkrmjBzcZEM4PhTQEMOGI5dqk=; b=Qgwvs7q+Z4AjAu6jPyZD5fu9rU
        CeckHuGNFh8PTRLCZDNld/Lxiq3/auUqE30cK74hk0Tc6G1zSu/ubdiIMN3yxSqxp1qbT1kN27NzI
        x4kq1XUGP4OJDafsBO7UufYJEl3L915CzFuAwif+vM4ZuMTIyD2KAv75DULcfP6U6RkPEHip2Vry2
        a70sLRbyTljdgYsunlwrHbev3PJgvnhp3KWiwGei7lO6N4BwAsCETtWJtXQ/1LWRlHP6IHACkQhbW
        NK2j2RPLXtyA3N1IunBFWuiQ8/VA82Xm1GC5KlCnJpn3UR5wZuggdkOsU4LrIb6domxEdZGAcNXIj
        1KTwfHSw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUT6R-0008Da-EV; Fri, 01 May 2020 10:41:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: remove set_fs from copy_strings_kernel
Date:   Fri,  1 May 2020 12:41:03 +0200
Message-Id: <20200501104105.2621149-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al and Andrew,

can one of you pick up this small series to avoid the set_fs
call in copy_strings_kernel?

