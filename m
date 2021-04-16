Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2733626EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbhDPRfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 13:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbhDPRff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:35:35 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894AFC061574;
        Fri, 16 Apr 2021 10:35:10 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXSN2-005oif-6a; Fri, 16 Apr 2021 17:35:08 +0000
Date:   Fri, 16 Apr 2021 17:35:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     christian.brauner@ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cccheng@synology.com
Subject: Re: [PATCH] hfsplus: prevent negative dentries when casefolded
Message-ID: <YHnKzF8OXWn6GRbc@zeniv-ca.linux.org.uk>
References: <20210416172012.8667-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416172012.8667-1-cccheng@synology.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 17, 2021 at 01:20:12AM +0800, Chung-Chiang Cheng wrote:
> hfsplus uses the case-insensitive filenames by default, but VFS negative
> dentries are incompatible with case-insensitive. For example, the
> following instructions will get a cached filename 'aaa' which isn't
> expected. There is no such problem in macOS.

Look into the way vfat et.al. are dealing with that (see their
->d_revalidate()).
