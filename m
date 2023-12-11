Return-Path: <linux-fsdevel+bounces-5529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC380D29A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEF61C21454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451794CDE1;
	Mon, 11 Dec 2023 16:44:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDADD2;
	Mon, 11 Dec 2023 08:44:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D47DA68B05; Mon, 11 Dec 2023 17:44:43 +0100 (CET)
Date: Mon, 11 Dec 2023 17:44:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v5 03/17] fs/f2fs: Restore the whint_mode mount option
Message-ID: <20231211164443.GA25306@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-4-bvanassche@acm.org> <20231207174529.GC31184@lst.de> <fd6d207d-fe03-4fdf-bd74-3463860135ef@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd6d207d-fe03-4fdf-bd74-3463860135ef@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 07, 2023 at 09:39:06AM -1000, Bart Van Assche wrote:
> On 12/7/23 07:45, Christoph Hellwig wrote:
>> On Wed, Nov 29, 2023 at 05:33:08PM -0800, Bart Van Assche wrote:
>>> Restore support for the whint_mode mount option by reverting commit
>>> 930e2607638d ("f2fs: remove obsolete whint_mode").
>>
>> I know that commit sets a precedence by having a horribly short and
>> uninformative commit message, but please write a proper one for this
>> commit and explain why you are restoring the option.  Also if anything
>> changed since last year.
>
> Hi Christoph,
>
> A possible approach is that I drop this patch from this patch series and
> that I let the F2FS maintainers restore write hint support in F2FS.

I'm not saying you should drop it.  Just that it should have a useful
commit message.

