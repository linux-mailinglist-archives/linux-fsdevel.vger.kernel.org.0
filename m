Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6B376353
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhEGKME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 06:12:04 -0400
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:49182 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhEGKMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 06:12:03 -0400
Received: from SZ-11126892.vivo.xyz (unknown [58.251.74.232])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id DAE0A2800BD;
        Fri,  7 May 2021 18:04:30 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     changfengnan@vivo.com
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
Date:   Fri,  7 May 2021 18:04:29 +0800
Message-Id: <20210507100429.1804-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
In-Reply-To: <20210130085003.1392-1-changfengnan@vivo.com>
References: <20210130085003.1392-1-changfengnan@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGk9LSlZMHUJJSE8ZHh8eQhpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6Lgw*Cz8NATowNRkfAhxJ
        QiwaFCNVSlVKTUlLSENKQ0xKSEpIVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBQktCNwY+
X-HM-Tid: 0a7946492b92da03kuwsdae0a2800bd
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

