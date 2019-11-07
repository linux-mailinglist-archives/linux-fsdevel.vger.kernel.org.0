Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09114F39E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfKGUxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 15:53:46 -0500
Received: from sandeen.net ([63.231.237.45]:35644 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfKGUxp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:53:45 -0500
Received: by sandeen.net (Postfix, from userid 500)
        id A08311911C; Thu,  7 Nov 2019 14:52:35 -0600 (CST)
From:   Eric Sandeen <sandeen@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Subject: [PATCH 0/2 V2] avoid softlockups in various s_inodes iterators
Date:   Thu,  7 Nov 2019 14:52:32 -0600
Message-Id: <1573159954-27846-1-git-send-email-sandeen@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2 patches to make sure we either schedule in an s_inodes walking
loop, or do our best to limit the size of the walk, to avoid soft
lockups.

V2 to fix inexplicable patch mangling

Thanks,
-Eric

