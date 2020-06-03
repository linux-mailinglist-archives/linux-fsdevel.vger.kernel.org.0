Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D640E1EC8F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 07:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgFCFwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 01:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFCFwp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 01:52:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A79C05BD43;
        Tue,  2 Jun 2020 22:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=G0RtHqaz3jwThDFK2q4jT4y1WFdSD5chLgza8Ln0Tns=; b=S54r37A102cVdIiLR9ikrZln+h
        +WqkJz/J5GgpgnRWePR/j3D3ICzQYNOhdFacEEI4MY8pPDhJJY228uyWTz8F5Y+G0Gu81WPOxamKA
        kYLxWLR6zjD92z5Dli8NtLJltTsb2BIt2F+UqZfm7mmYDY0S9bVwZM+C4GZNzjjihlb+LmWfXDbVe
        IOnxQkTE170brxgMnSqLDLFx2fzFvAQvKwVXdsf0LQBjkmQoWgQjGQJwUEz1pAzamr3sZwy9SmKIL
        dUON6sQqXrYHJYlopE73pRFYZtp9uYc+njHHcrLH2BwAfoEFF+NAeUWhyCn/spYcXxLV28imW6jbN
        v/t82Ing==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgMKN-0003nL-NK; Wed, 03 Jun 2020 05:52:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: fixes for work.sysctl
Date:   Wed,  3 Jun 2020 07:52:33 +0200
Message-Id: <20200603055237.677416-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

a bunch of fixes for the sysctl kernel pointer conversion against your
work.sysctl branch.  Only the first one is a real behavior fix, the rest
just removes left over __user annotations.
