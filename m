Return-Path: <linux-fsdevel+bounces-505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A8D7CB86C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 04:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335ABB20FF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5B8C13;
	Tue, 17 Oct 2023 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5B8BF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 02:31:37 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39BAC;
	Mon, 16 Oct 2023 19:31:33 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S8dJx5xlpz8XrRF;
	Tue, 17 Oct 2023 10:31:29 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 39H2VMBo009607;
	Tue, 17 Oct 2023 10:31:22 +0800 (+08)
	(envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
	by mapi (Zmail) with MAPI id mid14;
	Tue, 17 Oct 2023 10:31:23 +0800 (CST)
Date: Tue, 17 Oct 2023 10:31:23 +0800 (CST)
X-Zmail-TransId: 2b09652df1fbffffffffc65-db2b1
X-Mailer: Zmail v1.0
Message-ID: <202310171031234639906@zte.com.cn>
In-Reply-To: <20231017005747.GB11424@frogsfrogsfrogs>
References: 20231013-tyrannisieren-umfassen-0047ab6279aa@brauner,202310131740571821517@zte.com.cn,20231017005747.GB11424@frogsfrogsfrogs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <cheng.lin130@zte.com.cn>
To: <djwong@kernel.org>, <brauner@kernel.org>
Cc: <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <david@fromorbit.com>,
        <hch@infradead.org>, <jiang.yong5@zte.com.cn>,
        <wang.liang82@zte.com.cn>, <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0hdIGZzOiBpbnRyb2R1Y2UgY2hlY2sgZm9yIGRyb3AvaW5jX25saW5r?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 39H2VMBo009607
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 652DF201.002/4S8dJx5xlpz8XrRF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> On Fri, Oct 13, 2023 at 05:40:57PM +0800, cheng.lin130@zte.com.cn wrote:
> > > On Fri, Oct 13, 2023 at 03:27:30PM +0800, cheng.lin130@zte.com.cn wrote:
> > > > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > > >
> > > > Avoid inode nlink overflow or underflow.
> > > >
> > > > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > > > ---
> > > I'm very confused. There's no explanation why that's needed. As it
> > > stands it's not possible to provide a useful review.
> > > I'm not saying it's wrong. I just don't understand why and even if this
> > > should please show up in the commit message.
> > In an xfs issue, there was an nlink underflow of a directory inode. There
> > is a key information in the kernel messages, that is the WARN_ON from
> > drop_nlink(). However, VFS did not prevent the underflow. I'm not sure
> > if this behavior is inadvertent or specifically designed. As an abnormal
> > situation, perhaps prohibiting nlink overflow or underflow is a better way
> > to handle it.
> > Request for your comment.
> I was trying to steer you towards modifying vfs_rmdir and vfs_unlink to
> check that i_nlink of the files involved aren't somehow already zero
> and returning -EFSCORRUPTED if they are.  Not messing around with
> drop_nlink.
> --D
It seems that VFS is not very concerned about the values of filesystem,
such as inode nlinks. And the defination of whether it is correct or incorrect
is left to the specific filesystem. However, in some places do have limit
up to s_max_links. Perhaps the limit down to zero is also reasonable.
Is that right？

