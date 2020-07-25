Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3E22DA29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 00:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGYWKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 18:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgGYWKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 18:10:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13EC08C5C0;
        Sat, 25 Jul 2020 15:10:33 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzSN4-002ZNA-Lr; Sat, 25 Jul 2020 22:10:22 +0000
Date:   Sat, 25 Jul 2020 23:10:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pascal Bouchareine <kalou@tfz.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] proc,fcntl: introduce F_SET_DESCRIPTION
Message-ID: <20200725221022.GQ2786714@ZenIV.linux.org.uk>
References: <20200725004043.32326-1-kalou@tfz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725004043.32326-1-kalou@tfz.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:40:43PM -0700, Pascal Bouchareine wrote:
> This command attaches a description to a file descriptor for
> troubleshooting purposes. The free string is displayed in the
> process fdinfo file for that fd /proc/pid/fdinfo/fd.
> 
> One intended usage is to allow processes to self-document sockets
> for netstat and friends to report

Have you even tried to test it?  When will it ever free those things?
