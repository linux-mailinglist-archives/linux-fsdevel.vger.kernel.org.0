Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D917D2A317D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgKBR1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:27:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:49880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbgKBR1j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:27:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0867FB2C8
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 17:27:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7AEC61E12FB; Mon,  2 Nov 2020 18:27:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] quota: Handle corrupted quota file better
Date:   Mon,  2 Nov 2020 18:27:31 +0100
Message-Id: <20201102172733.23444-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has spotted that quota code does not handle corrupted quota files quite
well. Let's add some sanity checks to avoid kernel crashes when accessing
corrupted quota files.

								Honza
