Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7838D324AB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhBYHEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:04:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20154 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYHDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236630; x=1645772630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rH5iN7rn92uPR0ysMKjfAmxiSw1Pmu3vy8Md5TSv4fg=;
  b=VKKnflfCFxppNR+P8jeSisINiPLB8fzxwiFXJ407l9t+KZLEzyrciGmz
   O86522RWOUVHPSP5g9Cz+rNDTvv9ncmznWMClPgPPAO/G+kTIsYosG36y
   lBkqYJUsic2A1rjCi2TagWPaPaTXg6pIVsHXfCi5Me4RPtHJQwgitXujq
   y8IiqBxpty8OWAlTPW26NKQgcOMN4kChMRlSYVh9jfCT6I1zLb4aeM1mN
   MY7UR9id8kiruGsRruR4Ll8C9bb9qHTHo1EG2y8TMJ5LN3vHT1tRLKC1p
   4fWuN8WNZx0Jeam9oo9kln8HwZN8egeI0kuNbzI8smxdpbyX722mimpHw
   Q==;
IronPort-SDR: ULnBBBGLh0L0gyqDVr+kmbM6PiXy1/+wZEmXZJKxj+5dPYs6rLIrrCBr/7vAIhjk+/5k1eO4Cc
 mNdclhiKDrwIfyX7Lc+McFv+wBcJ7cNPVM6oBzrF2kE8Lx8PkpO9d59pjoPqqE+acpMBQ4QbXo
 rnTiv3HfBApTZE9bhmpi/IViqfgRsC6rR4GvFwJNi3o2TmKvEZgH9Chhoo1FQT0E2FLN8P7DsD
 jyku7o/ttpvscmjNPSim7+HJ9Wl9RLwekcc44X739MytP+5Ys8YvtkkPl6UJZo+QtV0O4YWRw3
 FyM=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="165245572"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:02:44 +0800
IronPort-SDR: EXQUEeb5nG0MO205VBuLPU3bDAPaQtSsdHZdCWcsbA7IMz8c3LGQA+PIhLfgCY32r+m+viAQMs
 srV9RsNjNZploKEL130xDkOWjzeyY29orlRY/u/XNeJKWAe/NlUvLGJ5Tnr8hTUEUc6qJhww38
 alsvasd3xgTs/cJT+S1wA3Xb+o5ku97+E5+h36g/me99jilLLjqaFTOrdy/Cos1DY3iz8m+DJ1
 GvjMcY2nFgpVXFtEv8KWAoEMu5gxx+8/GHKwLFMbyUZPWlSoECfdXFj6n1pNizP2DeqfwenH9V
 LpcHHIngw2JJVruAvYiBBPEq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:45:59 -0800
IronPort-SDR: ohwHLqpj7cwmf8bSCIxFSMmXiWDbqEFdBWqABl/E9NKhwZob1oX/i+46tCA3olFir2yXGJjcSp
 5c4oj107xA9/nC9yMMjkLlW5zdyHuDzTHHya67m4fLVdxOVLKDIB1AYdtp4zu9tmED6dU70fD9
 bP2MQn2YOnXY9nVYvtK+48S8+TZkTic+J57u33VHbxhCM8i0do+w2I6o0hUHw3fdrIRYdLnsDO
 938IasEn/iPKSn5PV4IOLZX6eqhDLZ9izvBFpc19Pf7lzQriWldROypGi6lbIGSWwFzRnqduF9
 sVI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:02:43 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 00/39] blktrace: add block trace extension support
Date:   Wed, 24 Feb 2021 23:01:52 -0800
Message-Id: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is an updated RFC that adds support for newly introduced
request operations REQ_OP_ZONE_APPEND along with the rest of the  
REQ_OP_ZONE_XXX. Please find the test log at the end of this patch.

The new strings "ZA" -> Zone Append, I do have userspace code changes
for this, if anyone is interested I'll post them, but before that I need 
approval that this approach is accepted so we can move forward.

Original Cover letter stays the same :-

This patch series adds support to track more request based flags and
different request fields to the blktrace infrastructure.

In this series, we increase the action, action mask field and add  
priority and priority mask field to existing infrastructure.

We add new structures to hold the trace where we increase the size of
the action field and add a new member to track the priority of the I/O. 
For the trace management side, we add new IOCTLs so that users can  
configure trace extensions from the blktrace user-space tools.

The RFC is still light on the details. With new IOCTLs I was able to
get the code running with user-space tools. There is still some more 
scope to optimize the code and reduce the duplicate code, but I kept 
it simple for now so that it is easy to review. I'm aware of some 
checkpatch.pl warnings I'll fix that in the next version along with nits.

It will be great if someone can review this code and provide some 
feedback. Below test log contains :-

* Zone Append operation with all possible (16) priority masks.
* Zone Management operations Zone-Open, Zone-Close, Zone-Finish,
  Zone-Reset-All with all possible (16) priority masks.
* Basic tracepoint testing such as Queue, Get, Merge, Issue, Dispatch,
  Complete, Split, Bounce, with all the priority values masks.
  Tracepoints with different Schedulers such as kyber, bfq, mq-deadline.

-ck

Chaitanya Kulkarni (39):
  blktrace_api: add new trace definitions
  blktrace_api: add new trace definition
  blkdev.h: add new trace ext as a queue member
  blktrace: add a new global list
  blktrace: add trace note APIs
  blktrace: add act and prio check helpers
  blktrace: add core trace API
  blktrace: update blk_add_trace_rq()
  blktrace: update blk_add_trace_rq_insert()
  blktrace: update blk_add_trace_rq_issue()
  blktrace: update blk_add_trace_rq_requeue()
  blktrace: update blk_add_trace_rq_complete()
  blktrace: update blk_add_trace_bio()
  blktrace: update blk_add_trace_bio_bounce()
  blktrace: update blk_add_trace_bio_complete()
  blktrace: update blk_add_trace_bio_backmerge()
  blktrace: update blk_add_trace_bio_frontmerge()
  blktrace: update blk_add_trace_bio_queue()
  blktrace: update blk_add_trace_getrq()
  blktrace: update blk_add_trace_plug()
  blktrace: update blk_add_trace_unplug()
  blktrace: update blk_add_trace_split()
  blktrace: update blk_add_trace_bio_remap()
  blktrace: update blk_add_trace_rq_remap()
  blktrace: update blk_add_driver_data()
  blktrace: add trace entry & pdu helpers
  blktrace: add a new formatting routine
  blktrace: add blk_log_xxx helpers()
  blktrace: link blk_log_xxx() to trace action
  blktrace: add trace event print helper
  blktrace: add trace_synthesize helper
  blktrace: add trace print helpers
  blktrace: add blkext tracer
  blktrace: implement setup-start-stop ioclts
  block: update blkdev_ioctl with new trace ioctls
  blktrace: add integrity tracking support
  blktrace: update blk_fill_rwbs() with new requests
  blktrace: track zone appaend completion sector
  blktrace: debug patch for the demo

 block/blk-lib.c                   |    4 +
 block/blk-zoned.c                 |    1 +
 block/ioctl.c                     |    4 +
 drivers/block/null_blk/main.c     |   32 +-
 drivers/block/null_blk/null_blk.h |    1 +
 include/linux/blkdev.h            |    1 +
 include/linux/blktrace_api.h      |   18 +
 include/uapi/linux/blktrace_api.h |  113 ++-
 include/uapi/linux/fs.h           |    5 +
 kernel/trace/blktrace.c           | 1437 +++++++++++++++++++++++++++--
 kernel/trace/trace.h              |    1 +
 11 files changed, 1535 insertions(+), 82 deletions(-)

#######################################################################
* Zone Append operation with all the priority masks :-
#######################################################################
---------------------------------------------
Using Priority mask 0x1
---------------------------------------------
---------------------------------------------
Using Priority mask 0x1
---------------------------------------------
---------------------------------------------
Using Priority mask 0x1
---------------------------------------------
252,0   23        1     4.888123821 17964  Q ZAS N 262144 + 8 [dd]
252,0   23        2     4.888131626 17964  G ZAS N 262144 + 8 [dd]
252,0   23        3     4.888196568 17964  I ZAS N 262144 + 8 [dd]
252,0   23        4     4.888544410  1062  D ZAS N 262144 + 8 [kworker/23:1H]
252,0   23        5     4.888602319   127  C ZAS N 262144 + 8 [0] <262144>
252,0   23        6     4.888686647 17964  Q ZAS N 262144 + 8 [dd]
252,0   23        7     4.888690865 17964  G ZAS N 262144 + 8 [dd]
252,0   23        8     4.888693279 17964  I ZAS N 262144 + 8 [dd]
252,0   23        9     4.888710582  1062  D ZAS N 262144 + 8 [kworker/23:1H]
252,0   23       10     4.888750416   127  C ZAS N 262152 + 8 [0] <262152>
252,0   23       11     4.888772147 17964  Q ZAS N 262144 + 8 [dd]
252,0   23       12     4.888775433 17964  G ZAS N 262144 + 8 [dd]
252,0   23       13     4.888777577 17964  I ZAS N 262144 + 8 [dd]
252,0   23       14     4.888792045  1062  D ZAS N 262144 + 8 [kworker/23:1H]
252,0   23       15     4.888827731   127  C ZAS N 262160 + 8 [0] <262160>
252,0   23       16     4.888848090 17964  Q ZAS N 262144 + 8 [dd]
252,0   23       17     4.888851336 17964  G ZAS N 262144 + 8 [dd]
252,0   23       18     4.888853810 17964  I ZAS N 262144 + 8 [dd]
252,0   23       19     4.888867837  1062  D ZAS N 262144 + 8 [kworker/23:1H]
252,0   23       20     4.888902732   127  C ZAS N 262168 + 8 [0] <262168>
252,0   23       21     4.888922850 17964  Q ZAS N 262144 + 8 [dd]
252,0   23       22     4.888926046 17964  G ZAS N 262144 + 8 [dd]
252,0   23       23     4.888928090 17964  I ZAS N 262144 + 8 [dd]
252,0   23       24     4.888941926  1062  D ZAS N 262144 + 8 [kworker/23:1H]
252,0   23       25     4.888976831   127  C ZAS N 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0x1
---------------------------------------------
CPU10 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU23 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 25 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x2
---------------------------------------------
---------------------------------------------
Using Priority mask 0x2
---------------------------------------------
252,0   13        1     4.922392196 18046  Q ZAS R 262144 + 8 [dd]
252,0   13        2     4.922443673 18046  G ZAS R 262144 + 8 [dd]
252,0   13        3     4.922449774 18046  I ZAS R 262144 + 8 [dd]
252,0   13        4     4.922506701   935  D ZAS R 262144 + 8 [kworker/13:1H]
252,0   13        5     4.922566122    77  C ZAS R 262144 + 8 [0] <262144>
---------------------------------------------
Using Priority mask 0x2
---------------------------------------------
---------------------------------------------
Using Priority mask 0x2
---------------------------------------------
252,0   13        6     4.922671730 18046  Q ZAS R 262144 + 8 [dd]
252,0   13        7     4.922676760 18046  G ZAS R 262144 + 8 [dd]
252,0   13        8     4.922679725 18046  I ZAS R 262144 + 8 [dd]
252,0   13        9     4.922701526   935  D ZAS R 262144 + 8 [kworker/13:1H]
252,0   13       10     4.922724529    77  C ZAS R 262152 + 8 [0] <262152>
252,0   13       11     4.922751089 18046  Q ZAS R 262144 + 8 [dd]
252,0   13       12     4.922755067 18046  G ZAS R 262144 + 8 [dd]
252,0   13       13     4.922757672 18046  I ZAS R 262144 + 8 [dd]
252,0   13       14     4.922776497   935  D ZAS R 262144 + 8 [kworker/13:1H]
252,0   13       15     4.922796995    77  C ZAS R 262160 + 8 [0] <262160>
252,0   13       16     4.922820499 18046  Q ZAS R 262144 + 8 [dd]
252,0   13       17     4.922824397 18046  G ZAS R 262144 + 8 [dd]
252,0   13       18     4.922826941 18046  I ZAS R 262144 + 8 [dd]
252,0   13       19     4.922844264   935  D ZAS R 262144 + 8 [kworker/13:1H]
252,0   13       20     4.922864011    77  C ZAS R 262168 + 8 [0] <262168>
252,0   13       21     4.922887555 18046  Q ZAS R 262144 + 8 [dd]
252,0   13       22     4.922891603 18046  G ZAS R 262144 + 8 [dd]
252,0   13       23     4.922894127 18046  I ZAS R 262144 + 8 [dd]
252,0   13       24     4.922911099   935  D ZAS R 262144 + 8 [kworker/13:1H]
252,0   13       25     4.922930566    77  C ZAS R 262176 + 8 [0] <262176>
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU13 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 25 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x3
---------------------------------------------
---------------------------------------------
Using Priority mask 0x3
---------------------------------------------
252,0   10        1     4.902073472 18136  Q ZAS N 262144 + 8 [dd]
252,0   10        2     4.902078532 18136  G ZAS N 262144 + 8 [dd]
252,0   10        3     4.902081467 18136  I ZAS N 262144 + 8 [dd]
252,0   10        4     4.902106644  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10        5     4.902131832    62  C ZAS N 262144 + 8 [0] <262144>
252,0   10        6     4.902154123 18136  Q ZAS N 262144 + 8 [dd]
252,0   10        7     4.902157049 18136  G ZAS N 262144 + 8 [dd]
252,0   10        8     4.902158972 18136  I ZAS N 262144 + 8 [dd]
252,0   10        9     4.902172368  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       10     4.902188007    62  C ZAS N 262152 + 8 [0] <262152>
252,0   10       11     4.902205780 18136  Q ZAS N 262144 + 8 [dd]
252,0   10       12     4.902208686 18136  G ZAS N 262144 + 8 [dd]
252,0   10       13     4.902210519 18136  I ZAS N 262144 + 8 [dd]
252,0   10       14     4.902223213  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       15     4.902237650    62  C ZAS N 262160 + 8 [0] <262160>
252,0   10       16     4.902254512 18136  Q ZAS N 262144 + 8 [dd]
252,0   10       17     4.902257367 18136  G ZAS N 262144 + 8 [dd]
252,0   10       18     4.902259210 18136  I ZAS N 262144 + 8 [dd]
252,0   10       19     4.902271483  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       20     4.902285620    62  C ZAS N 262168 + 8 [0] <262168>
252,0   10       21     4.902302411 18136  Q ZAS N 262144 + 8 [dd]
252,0   10       22     4.902305147 18136  G ZAS N 262144 + 8 [dd]
252,0   10       23     4.902307020 18136  I ZAS N 262144 + 8 [dd]
252,0   10       24     4.902319123  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       25     4.902333139    62  C ZAS N 262176 + 8 [0] <262176>
252,0   12        1     4.918434585 18138  Q ZAS R 262144 + 8 [dd]
252,0   12        2     4.918441037 18138  G ZAS R 262144 + 8 [dd]
252,0   12        3     4.918444754 18138  I ZAS R 262144 + 8 [dd]
252,0   12        4     4.918477395   512  D ZAS R 262144 + 8 [kworker/12:1H]
252,0   12        5     4.918521738    72  C ZAS R 262144 + 8 [0] <262144>
---------------------------------------------
Using Priority mask 0x3
---------------------------------------------
---------------------------------------------
Using Priority mask 0x3
---------------------------------------------
252,0   12        6     4.918613049 18138  Q ZAS R 262144 + 8 [dd]
252,0   12        7     4.918617518 18138  G ZAS R 262144 + 8 [dd]
252,0   12        8     4.918620373 18138  I ZAS R 262144 + 8 [dd]
252,0   12        9     4.918639539   512  D ZAS R 262144 + 8 [kworker/12:1H]
252,0   12       10     4.918690885    72  C ZAS R 262152 + 8 [0] <262152>
252,0   12       11     4.918716373 18138  Q ZAS R 262144 + 8 [dd]
252,0   12       12     4.918720361 18138  G ZAS R 262144 + 8 [dd]
252,0   12       13     4.918722885 18138  I ZAS R 262144 + 8 [dd]
252,0   12       14     4.918740849   512  D ZAS R 262144 + 8 [kworker/12:1H]
252,0   12       15     4.918760215    72  C ZAS R 262160 + 8 [0] <262160>
252,0   12       16     4.918781936 18138  Q ZAS R 262144 + 8 [dd]
252,0   12       17     4.918785523 18138  G ZAS R 262144 + 8 [dd]
252,0   12       18     4.918787917 18138  I ZAS R 262144 + 8 [dd]
252,0   12       19     4.918803677   512  D ZAS R 262144 + 8 [kworker/12:1H]
252,0   12       20     4.918821971    72  C ZAS R 262168 + 8 [0] <262168>
252,0   12       21     4.918843211 18138  Q ZAS R 262144 + 8 [dd]
252,0   12       22     4.918846677 18138  G ZAS R 262144 + 8 [dd]
252,0   12       23     4.918849022 18138  I ZAS R 262144 + 8 [dd]
252,0   12       24     4.918864311   512  D ZAS R 262144 + 8 [kworker/12:1H]
252,0   12       25     4.918882695    72  C ZAS R 262176 + 8 [0] <262176>
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU10 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU12 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          10,       40KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       10,       40KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       10,       40KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 2,500KiB/s / 0KiB/s
Events (252,0): 50 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x4
---------------------------------------------
---------------------------------------------
Using Priority mask 0x4
---------------------------------------------
---------------------------------------------
Using Priority mask 0x4
---------------------------------------------
---------------------------------------------
Using Priority mask 0x4
---------------------------------------------
252,0   22        1     4.934925390 18230  Q ZAS B 262144 + 8 [dd]
252,0   22        2     4.934936972 18230  G ZAS B 262144 + 8 [dd]
252,0   22        3     4.934942422 18230  I ZAS B 262144 + 8 [dd]
252,0   22        4     4.934983329   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22        5     4.935061225   122  C ZAS B 262144 + 8 [0] <262144>
252,0   22        6     4.935094547 18230  Q ZAS B 262144 + 8 [dd]
252,0   22        7     4.935098995 18230  G ZAS B 262144 + 8 [dd]
252,0   22        8     4.935101510 18230  I ZAS B 262144 + 8 [dd]
252,0   22        9     4.935119825   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       10     4.935140543   122  C ZAS B 262152 + 8 [0] <262152>
252,0   22       11     4.935163236 18230  Q ZAS B 262144 + 8 [dd]
252,0   22       12     4.935212578 18230  G ZAS B 262144 + 8 [dd]
252,0   22       13     4.935223940 18230  I ZAS B 262144 + 8 [dd]
252,0   22       14     4.935242996   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       15     4.935264386   122  C ZAS B 262160 + 8 [0] <262160>
252,0   22       16     4.935289703 18230  Q ZAS B 262144 + 8 [dd]
252,0   22       17     4.935293450 18230  G ZAS B 262144 + 8 [dd]
252,0   22       18     4.935295895 18230  I ZAS B 262144 + 8 [dd]
252,0   22       19     4.935311875   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       20     4.935330690   122  C ZAS B 262168 + 8 [0] <262168>
252,0   22       21     4.935352130 18230  Q ZAS B 262144 + 8 [dd]
252,0   22       22     4.935356338 18230  G ZAS B 262144 + 8 [dd]
252,0   22       23     4.935358703 18230  I ZAS B 262144 + 8 [dd]
252,0   22       24     4.935374071   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       25     4.935392726   122  C ZAS B 262176 + 8 [0] <262176>
CPU22 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU26 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 25 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x5
---------------------------------------------
---------------------------------------------
Using Priority mask 0x5
---------------------------------------------
---------------------------------------------
Using Priority mask 0x5
---------------------------------------------
252,0   11        1     4.901048790 18306  Q ZAS N 262144 + 8 [dd]
252,0   11        2     4.901056835 18306  G ZAS N 262144 + 8 [dd]
252,0   11        3     4.901060813 18306  I ZAS N 262144 + 8 [dd]
252,0   11        4     4.901092873  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11        5     4.901128850    67  C ZAS N 262144 + 8 [0] <262144>
252,0   11        6     4.901152925 18306  Q ZAS N 262144 + 8 [dd]
252,0   11        7     4.901156001 18306  G ZAS N 262144 + 8 [dd]
252,0   11        8     4.901157945 18306  I ZAS N 262144 + 8 [dd]
252,0   11        9     4.901172031  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       10     4.901188482    67  C ZAS N 262152 + 8 [0] <262152>
252,0   11       11     4.901206215 18306  Q ZAS N 262144 + 8 [dd]
252,0   11       12     4.901209021 18306  G ZAS N 262144 + 8 [dd]
252,0   11       13     4.901210904 18306  I ZAS N 262144 + 8 [dd]
252,0   11       14     4.901223768  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       15     4.901257912    67  C ZAS N 262160 + 8 [0] <262160>
252,0   11       16     4.901293249 18306  Q ZAS N 262144 + 8 [dd]
252,0   11       17     4.901297066 18306  G ZAS N 262144 + 8 [dd]
252,0   11       18     4.901300001 18306  I ZAS N 262144 + 8 [dd]
252,0   11       19     4.901316913  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       20     4.901333113    67  C ZAS N 262168 + 8 [0] <262168>
252,0   11       21     4.901351668 18306  Q ZAS N 262144 + 8 [dd]
252,0   11       22     4.901355004 18306  G ZAS N 262144 + 8 [dd]
252,0   11       23     4.901357168 18306  I ZAS N 262144 + 8 [dd]
252,0   11       24     4.901371846  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       25     4.901388878    67  C ZAS N 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0x5
---------------------------------------------
252,0   17        1     4.929512870 18310  Q ZAS B 262144 + 8 [dd]
252,0   17        2     4.929517789 18310  G ZAS B 262144 + 8 [dd]
252,0   17        3     4.929520594 18310  I ZAS B 262144 + 8 [dd]
252,0   17        4     4.929544629  1633  D ZAS B 262144 + 8 [kworker/17:1H]
252,0   17        5     4.929569256    97  C ZAS B 262144 + 8 [0] <262144>
252,0   17        6     4.929590626 18310  Q ZAS B 262144 + 8 [dd]
252,0   17        7     4.929593691 18310  G ZAS B 262144 + 8 [dd]
252,0   17        8     4.929595625 18310  I ZAS B 262144 + 8 [dd]
252,0   17        9     4.929608870  1633  D ZAS B 262144 + 8 [kworker/17:1H]
252,0   17       10     4.929625170    97  C ZAS B 262152 + 8 [0] <262152>
252,0   17       11     4.929642844 18310  Q ZAS B 262144 + 8 [dd]
252,0   17       12     4.929653183 18310  G ZAS B 262144 + 8 [dd]
252,0   17       13     4.929655187 18310  I ZAS B 262144 + 8 [dd]
252,0   17       14     4.929668862  1633  D ZAS B 262144 + 8 [kworker/17:1H]
252,0   17       15     4.929684902    97  C ZAS B 262160 + 8 [0] <262160>
252,0   17       16     4.929702876 18310  Q ZAS B 262144 + 8 [dd]
252,0   17       17     4.929705852 18310  G ZAS B 262144 + 8 [dd]
252,0   17       18     4.929707755 18310  I ZAS B 262144 + 8 [dd]
252,0   17       19     4.929720149  1633  D ZAS B 262144 + 8 [kworker/17:1H]
252,0   17       20     4.929735187    97  C ZAS B 262168 + 8 [0] <262168>
252,0   17       21     4.929752179 18310  Q ZAS B 262144 + 8 [dd]
252,0   17       22     4.929754894 18310  G ZAS B 262144 + 8 [dd]
252,0   17       23     4.929756697 18310  I ZAS B 262144 + 8 [dd]
252,0   17       24     4.929768780  1633  D ZAS B 262144 + 8 [kworker/17:1H]
252,0   17       25     4.929784399    97  C ZAS B 262176 + 8 [0] <262176>
CPU6 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU11 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU17 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          10,       40KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       10,       40KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       10,       40KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 1,428KiB/s / 0KiB/s
Events (252,0): 50 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x6
---------------------------------------------
---------------------------------------------
Using Priority mask 0x6
---------------------------------------------
---------------------------------------------
Using Priority mask 0x6
---------------------------------------------
---------------------------------------------
Using Priority mask 0x6
---------------------------------------------
252,0   19        1     4.942719787 18390  Q ZAS B 262144 + 8 [dd]
252,0   19        2     4.942726620 18390  G ZAS B 262144 + 8 [dd]
252,0   19        3     4.942730507 18390  I ZAS B 262144 + 8 [dd]
252,0   19        4     4.942762688  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19        5     4.942825175   107  C ZAS B 262144 + 8 [0] <262144>
252,0   19        6     4.942854450 18390  Q ZAS B 262144 + 8 [dd]
252,0   19        7     4.942858908 18390  G ZAS B 262144 + 8 [dd]
252,0   19        8     4.942861413 18390  I ZAS B 262144 + 8 [dd]
252,0   19        9     4.942879707  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       10     4.942922698   107  C ZAS B 262152 + 8 [0] <262152>
252,0   19       11     4.942947574 18390  Q ZAS B 262144 + 8 [dd]
252,0   19       12     4.942951472 18390  G ZAS B 262144 + 8 [dd]
252,0   19       13     4.942953866 18390  I ZAS B 262144 + 8 [dd]
252,0   19       14     4.942971108  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       15     4.943013588   107  C ZAS B 262160 + 8 [0] <262160>
252,0   19       16     4.943037974 18390  Q ZAS B 262144 + 8 [dd]
252,0   19       17     4.943041971 18390  G ZAS B 262144 + 8 [dd]
252,0   19       18     4.943044456 18390  I ZAS B 262144 + 8 [dd]
252,0   19       19     4.943061308  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       20     4.943102976   107  C ZAS B 262168 + 8 [0] <262168>
252,0   19       21     4.943126790 18390  Q ZAS B 262144 + 8 [dd]
252,0   19       22     4.943130497 18390  G ZAS B 262144 + 8 [dd]
252,0   19       23     4.943132892 18390  I ZAS B 262144 + 8 [dd]
252,0   19       24     4.943149132  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       25     4.943234392   107  C ZAS B 262176 + 8 [0] <262176>
252,0   14        1     4.925016367 18388  Q ZAS R 262144 + 8 [dd]
252,0   14        2     4.925023200 18388  G ZAS R 262144 + 8 [dd]
252,0   14        3     4.925026967 18388  I ZAS R 262144 + 8 [dd]
252,0   14        4     4.925064988   956  D ZAS R 262144 + 8 [kworker/14:1H]
252,0   14        5     4.925097800    82  C ZAS R 262144 + 8 [0] <262144>
252,0   14        6     4.925125662 18388  Q ZAS R 262144 + 8 [dd]
252,0   14        7     4.925129690 18388  G ZAS R 262144 + 8 [dd]
252,0   14        8     4.925132114 18388  I ZAS R 262144 + 8 [dd]
252,0   14        9     4.925149487   956  D ZAS R 262144 + 8 [kworker/14:1H]
252,0   14       10     4.925169104    82  C ZAS R 262152 + 8 [0] <262152>
252,0   14       11     4.925219268 18388  Q ZAS R 262144 + 8 [dd]
252,0   14       12     4.925223315 18388  G ZAS R 262144 + 8 [dd]
252,0   14       13     4.925225810 18388  I ZAS R 262144 + 8 [dd]
252,0   14       14     4.925243894   956  D ZAS R 262144 + 8 [kworker/14:1H]
252,0   14       15     4.925264272    82  C ZAS R 262160 + 8 [0] <262160>
252,0   14       16     4.925286344 18388  Q ZAS R 262144 + 8 [dd]
252,0   14       17     4.925289920 18388  G ZAS R 262144 + 8 [dd]
252,0   14       18     4.925292235 18388  I ZAS R 262144 + 8 [dd]
252,0   14       19     4.925308044   956  D ZAS R 262144 + 8 [kworker/14:1H]
252,0   14       20     4.925326619    82  C ZAS R 262168 + 8 [0] <262168>
252,0   14       21     4.925347829 18388  Q ZAS R 262144 + 8 [dd]
252,0   14       22     4.925351315 18388  G ZAS R 262144 + 8 [dd]
252,0   14       23     4.925353600 18388  I ZAS R 262144 + 8 [dd]
252,0   14       24     4.925368989   956  D ZAS R 262144 + 8 [kworker/14:1H]
252,0   14       25     4.925387623    82  C ZAS R 262176 + 8 [0] <262176>
CPU6 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU14 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU19 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          10,       40KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       10,       40KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       10,       40KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 50 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x7
---------------------------------------------
---------------------------------------------
Using Priority mask 0x7
---------------------------------------------
---------------------------------------------
Using Priority mask 0x7
---------------------------------------------
252,0    6        1     4.913824709 18469  Q ZAS R 262144 + 8 [dd]
252,0    6        2     4.913841370 18469  G ZAS R 262144 + 8 [dd]
252,0    6        3     4.913846439 18469  I ZAS R 262144 + 8 [dd]
252,0    6        4     4.913884030   814  D ZAS R 262144 + 8 [kworker/6:1H]
252,0    6        5     4.913925057    42  C ZAS R 262144 + 8 [0] <262144>
252,0    6        6     4.913956486 18469  Q ZAS R 262144 + 8 [dd]
252,0    6        7     4.913960513 18469  G ZAS R 262144 + 8 [dd]
252,0    6        8     4.913962988 18469  I ZAS R 262144 + 8 [dd]
252,0    6        9     4.913980661   814  D ZAS R 262144 + 8 [kworker/6:1H]
252,0    6       10     4.914007311    42  C ZAS R 262152 + 8 [0] <262152>
252,0    6       11     4.914031076 18469  Q ZAS R 262144 + 8 [dd]
252,0    6       12     4.914034863 18469  G ZAS R 262144 + 8 [dd]
252,0    6       13     4.914037257 18469  I ZAS R 262144 + 8 [dd]
252,0    6       14     4.914053888   814  D ZAS R 262144 + 8 [kworker/6:1H]
252,0    6       15     4.914079206    42  C ZAS R 262160 + 8 [0] <262160>
252,0    6       16     4.914102339 18469  Q ZAS R 262144 + 8 [dd]
252,0    6       17     4.914106157 18469  G ZAS R 262144 + 8 [dd]
252,0    6       18     4.914108571 18469  I ZAS R 262144 + 8 [dd]
252,0    6       19     4.914124621   814  D ZAS R 262144 + 8 [kworker/6:1H]
252,0    6       20     4.914149368    42  C ZAS R 262168 + 8 [0] <262168>
252,0    6       21     4.914171810 18469  Q ZAS R 262144 + 8 [dd]
252,0    6       22     4.914175466 18469  G ZAS R 262144 + 8 [dd]
252,0    6       23     4.914177831 18469  I ZAS R 262144 + 8 [dd]
252,0    6       24     4.914193971   814  D ZAS R 262144 + 8 [kworker/6:1H]
252,0    6       25     4.914212656    42  C ZAS R 262176 + 8 [0] <262176>
252,0   13        1     4.896918925 18467  Q ZAS N 262144 + 8 [dd]
252,0   13        2     4.896929775 18467  G ZAS N 262144 + 8 [dd]
252,0   13        3     4.896935145 18467  I ZAS N 262144 + 8 [dd]
252,0   13        4     4.896973687   935  D ZAS N 262144 + 8 [kworker/13:1H]
252,0   13        5     4.897031295    77  C ZAS N 262144 + 8 [0] <262144>
252,0   13        6     4.897063957 18467  Q ZAS N 262144 + 8 [dd]
252,0   13        7     4.897067964 18467  G ZAS N 262144 + 8 [dd]
252,0   13        8     4.897070369 18467  I ZAS N 262144 + 8 [dd]
252,0   13        9     4.897088112   935  D ZAS N 262144 + 8 [kworker/13:1H]
252,0   13       10     4.897107649    77  C ZAS N 262152 + 8 [0] <262152>
252,0   13       11     4.897130702 18467  Q ZAS N 262144 + 8 [dd]
252,0   13       12     4.897134218 18467  G ZAS N 262144 + 8 [dd]
252,0   13       13     4.897136553 18467  I ZAS N 262144 + 8 [dd]
252,0   13       14     4.897152533   935  D ZAS N 262144 + 8 [kworker/13:1H]
252,0   13       15     4.897170717    77  C ZAS N 262160 + 8 [0] <262160>
252,0   13       16     4.897192618 18467  Q ZAS N 262144 + 8 [dd]
252,0   13       17     4.897196175 18467  G ZAS N 262144 + 8 [dd]
252,0   13       18     4.897198639 18467  I ZAS N 262144 + 8 [dd]
252,0   13       19     4.897214319   935  D ZAS N 262144 + 8 [kworker/13:1H]
252,0   13       20     4.897232162    77  C ZAS N 262168 + 8 [0] <262168>
252,0   13       21     4.897253432 18467  Q ZAS N 262144 + 8 [dd]
252,0   13       22     4.897257049 18467  G ZAS N 262144 + 8 [dd]
252,0   13       23     4.897259363 18467  I ZAS N 262144 + 8 [dd]
252,0   13       24     4.897274672   935  D ZAS N 262144 + 8 [kworker/13:1H]
252,0   13       25     4.897292606    77  C ZAS N 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0x7
---------------------------------------------
252,0   16        1     4.931739084 18471  Q ZAS B 262144 + 8 [dd]
252,0   16        2     4.931746338 18471  G ZAS B 262144 + 8 [dd]
252,0   16        3     4.931750175 18471  I ZAS B 262144 + 8 [dd]
252,0   16        4     4.931784710  1728  D ZAS B 262144 + 8 [kworker/16:1H]
252,0   16        5     4.931854450    92  C ZAS B 262144 + 8 [0] <262144>
252,0   16        6     4.931886310 18471  Q ZAS B 262144 + 8 [dd]
252,0   16        7     4.931890959 18471  G ZAS B 262144 + 8 [dd]
252,0   16        8     4.931893824 18471  I ZAS B 262144 + 8 [dd]
252,0   16        9     4.931913902  1728  D ZAS B 262144 + 8 [kworker/16:1H]
252,0   16       10     4.931935953    92  C ZAS B 262152 + 8 [0] <262152>
252,0   16       11     4.931960820 18471  Q ZAS B 262144 + 8 [dd]
252,0   16       12     4.931973313 18471  G ZAS B 262144 + 8 [dd]
252,0   16       13     4.931976089 18471  I ZAS B 262144 + 8 [dd]
252,0   16       14     4.931995335  1728  D ZAS B 262144 + 8 [kworker/16:1H]
252,0   16       15     4.932016344    92  C ZAS B 262160 + 8 [0] <262160>
252,0   16       16     4.932041261 18471  Q ZAS B 262144 + 8 [dd]
252,0   16       17     4.932045429 18471  G ZAS B 262144 + 8 [dd]
252,0   16       18     4.932047993 18471  I ZAS B 262144 + 8 [dd]
252,0   16       19     4.932065396  1728  D ZAS B 262144 + 8 [kworker/16:1H]
252,0   16       20     4.932085404    92  C ZAS B 262168 + 8 [0] <262168>
252,0   16       21     4.932108767 18471  Q ZAS B 262144 + 8 [dd]
252,0   16       22     4.932112665 18471  G ZAS B 262144 + 8 [dd]
252,0   16       23     4.932115310 18471  I ZAS B 262144 + 8 [dd]
252,0   16       24     4.932132582  1728  D ZAS B 262144 + 8 [kworker/16:1H]
252,0   16       25     4.932152369    92  C ZAS B 262176 + 8 [0] <262176>
CPU6 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU13 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU16 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          15,       60KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       15,       60KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       15,       60KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 3,333KiB/s / 0KiB/s
Events (252,0): 75 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x8
---------------------------------------------
---------------------------------------------
Using Priority mask 0x8
---------------------------------------------
---------------------------------------------
Using Priority mask 0x8
---------------------------------------------
---------------------------------------------
Using Priority mask 0x8
---------------------------------------------
252,0   21        1     4.939348956 18573  Q ZAS I 262144 + 8 [dd]
252,0   21        2     4.939355308 18573  G ZAS I 262144 + 8 [dd]
252,0   21        3     4.939359155 18573  I ZAS I 262144 + 8 [dd]
252,0   21        4     4.939391416   921  D ZAS I 262144 + 8 [kworker/21:1H]
252,0   21        5     4.939428085   117  C ZAS I 262144 + 8 [0] <262144>
252,0   21        6     4.939456107 18573  Q ZAS I 262144 + 8 [dd]
252,0   21        7     4.939460024 18573  G ZAS I 262144 + 8 [dd]
252,0   21        8     4.939462469 18573  I ZAS I 262144 + 8 [dd]
252,0   21        9     4.939480152   921  D ZAS I 262144 + 8 [kworker/21:1H]
252,0   21       10     4.939508024   117  C ZAS I 262152 + 8 [0] <262152>
252,0   21       11     4.939531809 18573  Q ZAS I 262144 + 8 [dd]
252,0   21       12     4.939535596 18573  G ZAS I 262144 + 8 [dd]
252,0   21       13     4.939538001 18573  I ZAS I 262144 + 8 [dd]
252,0   21       14     4.939554462   921  D ZAS I 262144 + 8 [kworker/21:1H]
252,0   21       15     4.939580631   117  C ZAS I 262160 + 8 [0] <262160>
252,0   21       16     4.939603383 18573  Q ZAS I 262144 + 8 [dd]
252,0   21       17     4.939607090 18573  G ZAS I 262144 + 8 [dd]
252,0   21       18     4.939609565 18573  I ZAS I 262144 + 8 [dd]
252,0   21       19     4.939625785   921  D ZAS I 262144 + 8 [kworker/21:1H]
252,0   21       20     4.939650732   117  C ZAS I 262168 + 8 [0] <262168>
252,0   21       21     4.939673164 18573  Q ZAS I 262144 + 8 [dd]
252,0   21       22     4.939677011 18573  G ZAS I 262144 + 8 [dd]
252,0   21       23     4.939679406 18573  I ZAS I 262144 + 8 [dd]
252,0   21       24     4.939695306   921  D ZAS I 262144 + 8 [kworker/21:1H]
252,0   21       25     4.939719681   117  C ZAS I 262176 + 8 [0] <262176>
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 25 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x9
---------------------------------------------
---------------------------------------------
Using Priority mask 0x9
---------------------------------------------
---------------------------------------------
Using Priority mask 0x9
---------------------------------------------
252,0    9        1     4.892085481 18647  Q ZAS N 262144 + 8 [dd]
252,0    9        2     4.892096742 18647  G ZAS N 262144 + 8 [dd]
252,0    9        3     4.892128201 18647  I ZAS N 262144 + 8 [dd]
252,0    9        4     4.892170159   799  D ZAS N 262144 + 8 [kworker/9:1H]
252,0    9        5     4.892219181    57  C ZAS N 262144 + 8 [0] <262144>
252,0    9        6     4.892254397 18647  Q ZAS N 262144 + 8 [dd]
252,0    9        7     4.892258665 18647  G ZAS N 262144 + 8 [dd]
252,0    9        8     4.892261240 18647  I ZAS N 262144 + 8 [dd]
252,0    9        9     4.892279144   799  D ZAS N 262144 + 8 [kworker/9:1H]
252,0    9       10     4.892298961    57  C ZAS N 262152 + 8 [0] <262152>
252,0    9       11     4.892321333 18647  Q ZAS N 262144 + 8 [dd]
252,0    9       12     4.892325000 18647  G ZAS N 262144 + 8 [dd]
252,0    9       13     4.892327424 18647  I ZAS N 262144 + 8 [dd]
252,0    9       14     4.892345128   799  D ZAS N 262144 + 8 [kworker/9:1H]
252,0    9       15     4.892363492    57  C ZAS N 262160 + 8 [0] <262160>
252,0    9       16     4.892385012 18647  Q ZAS N 262144 + 8 [dd]
252,0    9       17     4.892388559 18647  G ZAS N 262144 + 8 [dd]
252,0    9       18     4.892390873 18647  I ZAS N 262144 + 8 [dd]
252,0    9       19     4.892406563   799  D ZAS N 262144 + 8 [kworker/9:1H]
252,0    9       20     4.892424797    57  C ZAS N 262168 + 8 [0] <262168>
252,0    9       21     4.892445917 18647  Q ZAS N 262144 + 8 [dd]
252,0    9       22     4.892449423 18647  G ZAS N 262144 + 8 [dd]
252,0    9       23     4.892451838 18647  I ZAS N 262144 + 8 [dd]
252,0    9       24     4.892467126   799  D ZAS N 262144 + 8 [kworker/9:1H]
252,0    9       25     4.892485791    57  C ZAS N 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0x9
---------------------------------------------
252,0   22        1     4.944750535 18653  Q ZAS I 262144 + 8 [dd]
252,0   22        2     4.944756687 18653  G ZAS I 262144 + 8 [dd]
252,0   22        3     4.944760253 18653  I ZAS I 262144 + 8 [dd]
252,0   22        4     4.944789759   934  D ZAS I 262144 + 8 [kworker/22:1H]
252,0   22        5     4.944825786   122  C ZAS I 262144 + 8 [0] <262144>
252,0   22        6     4.944850863 18653  Q ZAS I 262144 + 8 [dd]
252,0   22        7     4.944854320 18653  G ZAS I 262144 + 8 [dd]
252,0   22        8     4.944856424 18653  I ZAS I 262144 + 8 [dd]
252,0   22        9     4.944871141   934  D ZAS I 262144 + 8 [kworker/22:1H]
252,0   22       10     4.944888855   122  C ZAS I 262152 + 8 [0] <262152>
252,0   22       11     4.944908081 18653  Q ZAS I 262144 + 8 [dd]
252,0   22       12     4.944911096 18653  G ZAS I 262144 + 8 [dd]
252,0   22       13     4.944913080 18653  I ZAS I 262144 + 8 [dd]
252,0   22       14     4.944926625   934  D ZAS I 262144 + 8 [kworker/22:1H]
252,0   22       15     4.944942726   122  C ZAS I 262160 + 8 [0] <262160>
252,0   22       16     4.944961651 18653  Q ZAS I 262144 + 8 [dd]
252,0   22       17     4.944964677 18653  G ZAS I 262144 + 8 [dd]
252,0   22       18     4.944966660 18653  I ZAS I 262144 + 8 [dd]
252,0   22       19     4.944979835   934  D ZAS I 262144 + 8 [kworker/22:1H]
252,0   22       20     4.944995845   122  C ZAS I 262168 + 8 [0] <262168>
252,0   22       21     4.945014049 18653  Q ZAS I 262144 + 8 [dd]
252,0   22       22     4.945017005 18653  G ZAS I 262144 + 8 [dd]
252,0   22       23     4.945019019 18653  I ZAS I 262144 + 8 [dd]
252,0   22       24     4.945032724   934  D ZAS I 262144 + 8 [kworker/22:1H]
252,0   22       25     4.945056248   122  C ZAS I 262176 + 8 [0] <262176>
CPU6 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU9 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU22 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          10,       40KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       10,       40KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       10,       40KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 769KiB/s / 0KiB/s
Events (252,0): 50 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xA
---------------------------------------------
---------------------------------------------
Using Priority mask 0xA
---------------------------------------------
---------------------------------------------
Using Priority mask 0xA
---------------------------------------------
---------------------------------------------
Using Priority mask 0xA
---------------------------------------------
252,0   19        1     4.922523362 18729  Q ZAS R 262144 + 8 [dd]
252,0   19        2     4.922530625 18729  G ZAS R 262144 + 8 [dd]
252,0   19        3     4.922534362 18729  I ZAS R 262144 + 8 [dd]
252,0   19        4     4.922565180  1629  D ZAS R 262144 + 8 [kworker/19:1H]
252,0   19        5     4.922604234   107  C ZAS R 262144 + 8 [0] <262144>
252,0   19        6     4.922644569 18729  Q ZAS R 262144 + 8 [dd]
252,0   19        7     4.922649007 18729  G ZAS R 262144 + 8 [dd]
252,0   19        8     4.922651622 18729  I ZAS R 262144 + 8 [dd]
252,0   19        9     4.922670327  1629  D ZAS R 262144 + 8 [kworker/19:1H]
252,0   19       10     4.922691217   107  C ZAS R 262152 + 8 [0] <262152>
252,0   19       11     4.922714340 18729  Q ZAS R 262144 + 8 [dd]
252,0   19       12     4.922717887 18729  G ZAS R 262144 + 8 [dd]
252,0   19       13     4.922720301 18729  I ZAS R 262144 + 8 [dd]
252,0   19       14     4.922736251  1629  D ZAS R 262144 + 8 [kworker/19:1H]
252,0   19       15     4.922755167   107  C ZAS R 262160 + 8 [0] <262160>
252,0   19       16     4.922776657 18729  Q ZAS R 262144 + 8 [dd]
252,0   19       17     4.922780234 18729  G ZAS R 262144 + 8 [dd]
252,0   19       18     4.922782658 18729  I ZAS R 262144 + 8 [dd]
252,0   19       19     4.922798358  1629  D ZAS R 262144 + 8 [kworker/19:1H]
252,0   19       20     4.922817203   107  C ZAS R 262168 + 8 [0] <262168>
252,0   19       21     4.922838393 18729  Q ZAS R 262144 + 8 [dd]
252,0   19       22     4.922841849 18729  G ZAS R 262144 + 8 [dd]
252,0   19       23     4.922844173 18729  I ZAS R 262144 + 8 [dd]
252,0   19       24     4.922859542  1629  D ZAS R 262144 + 8 [kworker/19:1H]
252,0   19       25     4.922877586   107  C ZAS R 262176 + 8 [0] <262176>
252,0   17        1     4.955555648 18733  Q ZAS I 262144 + 8 [dd]
252,0   17        2     4.955561870 18733  G ZAS I 262144 + 8 [dd]
252,0   17        3     4.955565327 18733  I ZAS I 262144 + 8 [dd]
252,0   17        4     4.955593129  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17        5     4.955630519    97  C ZAS I 262144 + 8 [0] <262144>
252,0   17        6     4.955654884 18733  Q ZAS I 262144 + 8 [dd]
252,0   17        7     4.955657980 18733  G ZAS I 262144 + 8 [dd]
252,0   17        8     4.955659974 18733  I ZAS I 262144 + 8 [dd]
252,0   17        9     4.955674000  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       10     4.955690010    97  C ZAS I 262152 + 8 [0] <262152>
252,0   17       11     4.955707734 18733  Q ZAS I 262144 + 8 [dd]
252,0   17       12     4.955710549 18733  G ZAS I 262144 + 8 [dd]
252,0   17       13     4.955712402 18733  I ZAS I 262144 + 8 [dd]
252,0   17       14     4.955725106  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       15     4.955750814    97  C ZAS I 262160 + 8 [0] <262160>
252,0   17       16     4.955769049 18733  Q ZAS I 262144 + 8 [dd]
252,0   17       17     4.955772124 18733  G ZAS I 262144 + 8 [dd]
252,0   17       18     4.955773988 18733  I ZAS I 262144 + 8 [dd]
252,0   17       19     4.955786892  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       20     4.955825164    97  C ZAS I 262168 + 8 [0] <262168>
252,0   17       21     4.955844480 18733  Q ZAS I 262144 + 8 [dd]
252,0   17       22     4.955847506 18733  G ZAS I 262144 + 8 [dd]
252,0   17       23     4.955849479 18733  I ZAS I 262144 + 8 [dd]
252,0   17       24     4.955862574  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       25     4.955898291    97  C ZAS I 262176 + 8 [0] <262176>
CPU17 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU19 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU34 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          10,       40KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       10,       40KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       10,       40KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 1,212KiB/s / 0KiB/s
Events (252,0): 50 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xB
---------------------------------------------
---------------------------------------------
Using Priority mask 0xB
---------------------------------------------
252,0   15        1     4.917518907 18809  Q ZAS R 262144 + 8 [dd]
252,0   15        2     4.917524597 18809  G ZAS R 262144 + 8 [dd]
252,0   15        3     4.917527593 18809  I ZAS R 262144 + 8 [dd]
252,0   15        4     4.917553792   827  D ZAS R 262144 + 8 [kworker/15:1H]
252,0   15        5     4.917588147    87  C ZAS R 262144 + 8 [0] <262144>
---------------------------------------------
Using Priority mask 0xB
---------------------------------------------
252,0   14        1     4.901540652 18807  Q ZAS N 262144 + 8 [dd]
252,0   14        2     4.901546092 18807  G ZAS N 262144 + 8 [dd]
252,0   14        3     4.901549419 18807  I ZAS N 262144 + 8 [dd]
252,0   14        4     4.901576389   956  D ZAS N 262144 + 8 [kworker/14:1H]
252,0   14        5     4.901602889    82  C ZAS N 262144 + 8 [0] <262144>
252,0   14        6     4.901624970 18807  Q ZAS N 262144 + 8 [dd]
252,0   14        7     4.901627926 18807  G ZAS N 262144 + 8 [dd]
252,0   14        8     4.901629880 18807  I ZAS N 262144 + 8 [dd]
252,0   14        9     4.901643235   956  D ZAS N 262144 + 8 [kworker/14:1H]
252,0   14       10     4.901658644    82  C ZAS N 262152 + 8 [0] <262152>
252,0   14       11     4.901676347 18807  Q ZAS N 262144 + 8 [dd]
252,0   14       12     4.901679222 18807  G ZAS N 262144 + 8 [dd]
252,0   14       13     4.901681066 18807  I ZAS N 262144 + 8 [dd]
252,0   14       14     4.901693729   956  D ZAS N 262144 + 8 [kworker/14:1H]
252,0   14       15     4.901708417    82  C ZAS N 262160 + 8 [0] <262160>
252,0   14       16     4.901725519 18807  Q ZAS N 262144 + 8 [dd]
252,0   14       17     4.901728404 18807  G ZAS N 262144 + 8 [dd]
252,0   14       18     4.901730288 18807  I ZAS N 262144 + 8 [dd]
252,0   14       19     4.901742461   956  D ZAS N 262144 + 8 [kworker/14:1H]
252,0   14       20     4.901757088    82  C ZAS N 262168 + 8 [0] <262168>
252,0   14       21     4.901773960 18807  Q ZAS N 262144 + 8 [dd]
252,0   14       22     4.901776735 18807  G ZAS N 262144 + 8 [dd]
252,0   14       23     4.901778548 18807  I ZAS N 262144 + 8 [dd]
252,0   14       24     4.901790611   956  D ZAS N 262144 + 8 [kworker/14:1H]
252,0   14       25     4.901804948    82  C ZAS N 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0xB
---------------------------------------------
252,0   37        1     4.951035942 18813  Q ZAS I 262144 + 8 [dd]
252,0   37        2     4.951047785 18813  G ZAS I 262144 + 8 [dd]
252,0   37        3     4.951053265 18813  I ZAS I 262144 + 8 [dd]
252,0   37        4     4.951093791  1060  D ZAS I 262144 + 8 [kworker/37:1H]
252,0   37        5     4.951144777   197  C ZAS I 262144 + 8 [0] <262144>
252,0   37        6     4.951178019 18813  Q ZAS I 262144 + 8 [dd]
252,0   37        7     4.951182036 18813  G ZAS I 262144 + 8 [dd]
252,0   37        8     4.951184591 18813  I ZAS I 262144 + 8 [dd]
252,0   37        9     4.951202555  1060  D ZAS I 262144 + 8 [kworker/37:1H]
252,0   37       10     4.951230828   197  C ZAS I 262152 + 8 [0] <262152>
252,0   37       11     4.951254973 18813  Q ZAS I 262144 + 8 [dd]
252,0   37       12     4.951258710 18813  G ZAS I 262144 + 8 [dd]
252,0   37       13     4.951261155 18813  I ZAS I 262144 + 8 [dd]
252,0   37       14     4.951277766  1060  D ZAS I 262144 + 8 [kworker/37:1H]
252,0   37       15     4.951303464   197  C ZAS I 262160 + 8 [0] <262160>
252,0   37       16     4.951326587 18813  Q ZAS I 262144 + 8 [dd]
252,0   37       17     4.951330234 18813  G ZAS I 262144 + 8 [dd]
252,0   37       18     4.951332669 18813  I ZAS I 262144 + 8 [dd]
252,0   37       19     4.951349791  1060  D ZAS I 262144 + 8 [kworker/37:1H]
252,0   37       20     4.951369047   197  C ZAS I 262168 + 8 [0] <262168>
252,0   37       21     4.951390678 18813  Q ZAS I 262144 + 8 [dd]
252,0   37       22     4.951394214 18813  G ZAS I 262144 + 8 [dd]
252,0   37       23     4.951396569 18813  I ZAS I 262144 + 8 [dd]
252,0   37       24     4.951412098  1060  D ZAS I 262144 + 8 [kworker/37:1H]
252,0   37       25     4.951430412   197  C ZAS I 262176 + 8 [0] <262176>
252,0   15        6     4.917681582 18809  Q ZAS R 262144 + 8 [dd]
252,0   15        7     4.917691661 18809  G ZAS R 262144 + 8 [dd]
252,0   15        8     4.917693945 18809  I ZAS R 262144 + 8 [dd]
252,0   15        9     4.917710366   827  D ZAS R 262144 + 8 [kworker/15:1H]
252,0   15       10     4.917728189    87  C ZAS R 262152 + 8 [0] <262152>
252,0   15       11     4.917747996 18809  Q ZAS R 262144 + 8 [dd]
252,0   15       12     4.917770048 18809  G ZAS R 262144 + 8 [dd]
252,0   15       13     4.917773504 18809  I ZAS R 262144 + 8 [dd]
252,0   15       14     4.917796467   827  D ZAS R 262144 + 8 [kworker/15:1H]
252,0   15       15     4.917821083    87  C ZAS R 262160 + 8 [0] <262160>
252,0   15       16     4.917853945 18809  Q ZAS R 262144 + 8 [dd]
252,0   15       17     4.917858604 18809  G ZAS R 262144 + 8 [dd]
252,0   15       18     4.917861539 18809  I ZAS R 262144 + 8 [dd]
252,0   15       19     4.917880565   827  D ZAS R 262144 + 8 [kworker/15:1H]
252,0   15       20     4.917903127    87  C ZAS R 262168 + 8 [0] <262168>
252,0   15       21     4.917928795 18809  Q ZAS R 262144 + 8 [dd]
252,0   15       22     4.917933033 18809  G ZAS R 262144 + 8 [dd]
252,0   15       23     4.917936310 18809  I ZAS R 262144 + 8 [dd]
252,0   15       24     4.917955856   827  D ZAS R 262144 + 8 [kworker/15:1H]
252,0   15       25     4.917977878    87  C ZAS R 262176 + 8 [0] <262176>
CPU13 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU14 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU15 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU37 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          15,       60KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       15,       60KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       15,       60KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 75 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xC
---------------------------------------------
---------------------------------------------
Using Priority mask 0xC
---------------------------------------------
---------------------------------------------
Using Priority mask 0xC
---------------------------------------------
---------------------------------------------
Using Priority mask 0xC
---------------------------------------------
252,0   19        1     4.937898766 18910  Q ZAS B 262144 + 8 [dd]
252,0   19        2     4.937906411 18910  G ZAS B 262144 + 8 [dd]
252,0   19        3     4.937910388 18910  I ZAS B 262144 + 8 [dd]
252,0   19        4     4.937942999  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19        5     4.937985329   107  C ZAS B 262144 + 8 [0] <262144>
252,0   19        6     4.938014203 18910  Q ZAS B 262144 + 8 [dd]
252,0   19        7     4.938018421 18910  G ZAS B 262144 + 8 [dd]
252,0   19        8     4.938021006 18910  I ZAS B 262144 + 8 [dd]
252,0   19        9     4.938038518  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       10     4.938058506   107  C ZAS B 262152 + 8 [0] <262152>
252,0   19       11     4.938080988 18910  Q ZAS B 262144 + 8 [dd]
252,0   19       12     4.938084575 18910  G ZAS B 262144 + 8 [dd]
252,0   19       13     4.938087019 18910  I ZAS B 262144 + 8 [dd]
252,0   19       14     4.938103039  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       15     4.938132024   107  C ZAS B 262160 + 8 [0] <262160>
252,0   19       16     4.938154726 18910  Q ZAS B 262144 + 8 [dd]
252,0   19       17     4.938158513 18910  G ZAS B 262144 + 8 [dd]
252,0   19       18     4.938160868 18910  I ZAS B 262144 + 8 [dd]
252,0   19       19     4.938177239  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       20     4.938195924   107  C ZAS B 262168 + 8 [0] <262168>
252,0   19       21     4.938217063 18910  Q ZAS B 262144 + 8 [dd]
252,0   19       22     4.938220630 18910  G ZAS B 262144 + 8 [dd]
252,0   19       23     4.938222914 18910  I ZAS B 262144 + 8 [dd]
252,0   19       24     4.938238313  1629  D ZAS B 262144 + 8 [kworker/19:1H]
252,0   19       25     4.938256026   107  C ZAS B 262176 + 8 [0] <262176>
252,0    6        1     4.955931744 18912  Q ZAS I 262144 + 8 [dd]
252,0    6        2     4.955941122 18912  G ZAS I 262144 + 8 [dd]
252,0    6        3     4.955945750 18912  I ZAS I 262144 + 8 [dd]
252,0    6        4     4.955982349   814  D ZAS I 262144 + 8 [kworker/6:1H]
252,0    6        5     4.956016463    42  C ZAS I 262144 + 8 [0] <262144>
252,0    6        6     4.956045628 18912  Q ZAS I 262144 + 8 [dd]
252,0    6        7     4.956049715 18912  G ZAS I 262144 + 8 [dd]
252,0    6        8     4.956052180 18912  I ZAS I 262144 + 8 [dd]
252,0    6        9     4.956070244   814  D ZAS I 262144 + 8 [kworker/6:1H]
252,0    6       10     4.956089811    42  C ZAS I 262152 + 8 [0] <262152>
252,0    6       11     4.956112213 18912  Q ZAS I 262144 + 8 [dd]
252,0    6       12     4.956116030 18912  G ZAS I 262144 + 8 [dd]
252,0    6       13     4.956118424 18912  I ZAS I 262144 + 8 [dd]
252,0    6       14     4.956134665   814  D ZAS I 262144 + 8 [kworker/6:1H]
252,0    6       15     4.956153480    42  C ZAS I 262160 + 8 [0] <262160>
252,0    6       16     4.956174910 18912  Q ZAS I 262144 + 8 [dd]
252,0    6       17     4.956178427 18912  G ZAS I 262144 + 8 [dd]
252,0    6       18     4.956180861 18912  I ZAS I 262144 + 8 [dd]
252,0    6       19     4.956196551   814  D ZAS I 262144 + 8 [kworker/6:1H]
252,0    6       20     4.956214985    42  C ZAS I 262168 + 8 [0] <262168>
252,0    6       21     4.956236065 18912  Q ZAS I 262144 + 8 [dd]
252,0    6       22     4.956239581 18912  G ZAS I 262144 + 8 [dd]
252,0    6       23     4.956241936 18912  I ZAS I 262144 + 8 [dd]
252,0    6       24     4.956257295   814  D ZAS I 262144 + 8 [kworker/6:1H]
252,0    6       25     4.956275008    42  C ZAS I 262176 + 8 [0] <262176>
CPU6 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU19 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          10,       40KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       10,       40KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       10,       40KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 2,222KiB/s / 0KiB/s
Events (252,0): 50 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xD
---------------------------------------------
---------------------------------------------
Using Priority mask 0xD
---------------------------------------------
---------------------------------------------
Using Priority mask 0xD
---------------------------------------------
252,0   10        1     4.895910053 18986  Q ZAS N 262144 + 8 [dd]
252,0   10        2     4.895919621 18986  G ZAS N 262144 + 8 [dd]
252,0   10        3     4.895924220 18986  I ZAS N 262144 + 8 [dd]
252,0   10        4     4.895961259  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10        5     4.896029597    62  C ZAS N 262144 + 8 [0] <262144>
252,0   10        6     4.896060846 18986  Q ZAS N 262144 + 8 [dd]
252,0   10        7     4.896065034 18986  G ZAS N 262144 + 8 [dd]
252,0   10        8     4.896067558 18986  I ZAS N 262144 + 8 [dd]
252,0   10        9     4.896085903  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       10     4.896185510    62  C ZAS N 262152 + 8 [0] <262152>
252,0   10       11     4.896213312 18986  Q ZAS N 262144 + 8 [dd]
252,0   10       12     4.896218061 18986  G ZAS N 262144 + 8 [dd]
252,0   10       13     4.896221106 18986  I ZAS N 262144 + 8 [dd]
252,0   10       14     4.896242687  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       15     4.896300816    62  C ZAS N 262160 + 8 [0] <262160>
252,0   10       16     4.896326133 18986  Q ZAS N 262144 + 8 [dd]
252,0   10       17     4.896329970 18986  G ZAS N 262144 + 8 [dd]
252,0   10       18     4.896332405 18986  I ZAS N 262144 + 8 [dd]
252,0   10       19     4.896349367  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       20     4.896393750    62  C ZAS N 262168 + 8 [0] <262168>
252,0   10       21     4.896417465 18986  Q ZAS N 262144 + 8 [dd]
252,0   10       22     4.896421292 18986  G ZAS N 262144 + 8 [dd]
252,0   10       23     4.896423656 18986  I ZAS N 262144 + 8 [dd]
252,0   10       24     4.896440237  1364  D ZAS N 262144 + 8 [kworker/10:1H]
252,0   10       25     4.896480833    62  C ZAS N 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0xD
---------------------------------------------
252,0   17        1     4.953401098 18992  Q ZAS I 262144 + 8 [dd]
252,0   17        2     4.953408331 18992  G ZAS I 262144 + 8 [dd]
252,0   17        3     4.953412459 18992  I ZAS I 262144 + 8 [dd]
252,0   17        4     4.953445201  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17        5     4.953510513    97  C ZAS I 262144 + 8 [0] <262144>
252,0   17        6     4.953540048 18992  Q ZAS I 262144 + 8 [dd]
252,0   17        7     4.953544176 18992  G ZAS I 262144 + 8 [dd]
252,0   17        8     4.953546641 18992  I ZAS I 262144 + 8 [dd]
252,0   17        9     4.953564514  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       10     4.953594591    97  C ZAS I 262152 + 8 [0] <262152>
252,0   17       11     4.953618786 18992  Q ZAS I 262144 + 8 [dd]
252,0   17       12     4.953622503 18992  G ZAS I 262144 + 8 [dd]
252,0   17       13     4.953624918 18992  I ZAS I 262144 + 8 [dd]
252,0   17       14     4.953641669  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       15     4.953682936    97  C ZAS I 262160 + 8 [0] <262160>
252,0   17       16     4.953707022 18992  Q ZAS I 262144 + 8 [dd]
252,0   17       17     4.953710859 18992  G ZAS I 262144 + 8 [dd]
252,0   17       18     4.953713363 18992  I ZAS I 262144 + 8 [dd]
252,0   17       19     4.953729814  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       20     4.953756214    97  C ZAS I 262168 + 8 [0] <262168>
252,0   17       21     4.953778476 18992  Q ZAS I 262144 + 8 [dd]
252,0   17       22     4.953782102 18992  G ZAS I 262144 + 8 [dd]
252,0   17       23     4.953784597 18992  I ZAS I 262144 + 8 [dd]
252,0   17       24     4.953800627  1633  D ZAS I 262144 + 8 [kworker/17:1H]
252,0   17       25     4.953819903    97  C ZAS I 262176 + 8 [0] <262176>
252,0   11        1     4.934531401 18990  Q ZAS B 262144 + 8 [dd]
252,0   11        2     4.934539566 18990  G ZAS B 262144 + 8 [dd]
252,0   11        3     4.934544065 18990  I ZAS B 262144 + 8 [dd]
252,0   11        4     4.934583238  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11        5     4.934681422    67  C ZAS B 262144 + 8 [0] <262144>
252,0   11        6     4.934716137 18990  Q ZAS B 262144 + 8 [dd]
252,0   11        7     4.934721317 18990  G ZAS B 262144 + 8 [dd]
252,0   11        8     4.934724433 18990  I ZAS B 262144 + 8 [dd]
252,0   11        9     4.934746214  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       10     4.934770369    67  C ZAS B 262152 + 8 [0] <262152>
252,0   11       11     4.934796738 18990  Q ZAS B 262144 + 8 [dd]
252,0   11       12     4.934800936 18990  G ZAS B 262144 + 8 [dd]
252,0   11       13     4.934803882 18990  I ZAS B 262144 + 8 [dd]
252,0   11       14     4.934823098  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       15     4.934845520    67  C ZAS B 262160 + 8 [0] <262160>
252,0   11       16     4.934871158 18990  Q ZAS B 262144 + 8 [dd]
252,0   11       17     4.934876077 18990  G ZAS B 262144 + 8 [dd]
252,0   11       18     4.934878933 18990  I ZAS B 262144 + 8 [dd]
252,0   11       19     4.934897748  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       20     4.934919809    67  C ZAS B 262168 + 8 [0] <262168>
252,0   11       21     4.934945477 18990  Q ZAS B 262144 + 8 [dd]
252,0   11       22     4.934949625 18990  G ZAS B 262144 + 8 [dd]
252,0   11       23     4.934952460 18990  I ZAS B 262144 + 8 [dd]
252,0   11       24     4.934970855  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       25     4.935001653    67  C ZAS B 262176 + 8 [0] <262176>
CPU4 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU10 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU11 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU17 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          15,       60KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       15,       60KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       15,       60KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 1,538KiB/s / 0KiB/s
Events (252,0): 75 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xE
---------------------------------------------
---------------------------------------------
Using Priority mask 0xE
---------------------------------------------
---------------------------------------------
Using Priority mask 0xE
---------------------------------------------
252,0   10        1     4.916599342 19068  Q ZAS R 262144 + 8 [dd]
252,0   10        2     4.916604522 19068  G ZAS R 262144 + 8 [dd]
252,0   10        3     4.916607427 19068  I ZAS R 262144 + 8 [dd]
252,0   10        4     4.916632224  1364  D ZAS R 262144 + 8 [kworker/10:1H]
252,0   10        5     4.916665997    62  C ZAS R 262144 + 8 [0] <262144>
252,0   10        6     4.916688279 19068  Q ZAS R 262144 + 8 [dd]
252,0   10        7     4.916691365 19068  G ZAS R 262144 + 8 [dd]
252,0   10        8     4.916693348 19068  I ZAS R 262144 + 8 [dd]
252,0   10        9     4.916709178  1364  D ZAS R 262144 + 8 [kworker/10:1H]
252,0   10       10     4.916725038    62  C ZAS R 262152 + 8 [0] <262152>
252,0   10       11     4.916742951 19068  Q ZAS R 262144 + 8 [dd]
252,0   10       12     4.916745957 19068  G ZAS R 262144 + 8 [dd]
252,0   10       13     4.916747770 19068  I ZAS R 262144 + 8 [dd]
252,0   10       14     4.916761186  1364  D ZAS R 262144 + 8 [kworker/10:1H]
252,0   10       15     4.916776354    62  C ZAS R 262160 + 8 [0] <262160>
252,0   10       16     4.916794007 19068  Q ZAS R 262144 + 8 [dd]
252,0   10       17     4.916796792 19068  G ZAS R 262144 + 8 [dd]
252,0   10       18     4.916798646 19068  I ZAS R 262144 + 8 [dd]
252,0   10       19     4.916810989  1364  D ZAS R 262144 + 8 [kworker/10:1H]
252,0   10       20     4.916827079    62  C ZAS R 262168 + 8 [0] <262168>
252,0   10       21     4.916848800 19068  Q ZAS R 262144 + 8 [dd]
252,0   10       22     4.916851545 19068  G ZAS R 262144 + 8 [dd]
252,0   10       23     4.916853469 19068  I ZAS R 262144 + 8 [dd]
252,0   10       24     4.916866774  1364  D ZAS R 262144 + 8 [kworker/10:1H]
252,0   10       25     4.916881161    62  C ZAS R 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0xE
---------------------------------------------
252,0   16        1     4.951868864 19072  Q ZAS I 262144 + 8 [dd]
252,0   16        2     4.951873683 19072  G ZAS I 262144 + 8 [dd]
252,0   16        3     4.951876589 19072  I ZAS I 262144 + 8 [dd]
252,0   16        4     4.951901716  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16        5     4.951936531    92  C ZAS I 262144 + 8 [0] <262144>
252,0   16        6     4.951959284 19072  Q ZAS I 262144 + 8 [dd]
252,0   16        7     4.951962480 19072  G ZAS I 262144 + 8 [dd]
252,0   16        8     4.951964494 19072  I ZAS I 262144 + 8 [dd]
252,0   16        9     4.951978400  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       10     4.951994700    92  C ZAS I 262152 + 8 [0] <262152>
252,0   16       11     4.952012403 19072  Q ZAS I 262144 + 8 [dd]
252,0   16       12     4.952015259 19072  G ZAS I 262144 + 8 [dd]
252,0   16       13     4.952017122 19072  I ZAS I 262144 + 8 [dd]
252,0   16       14     4.952029746  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       15     4.952044824    92  C ZAS I 262160 + 8 [0] <262160>
252,0   16       16     4.952061836 19072  Q ZAS I 262144 + 8 [dd]
252,0   16       17     4.952064611 19072  G ZAS I 262144 + 8 [dd]
252,0   16       18     4.952066435 19072  I ZAS I 262144 + 8 [dd]
252,0   16       19     4.952078818  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       20     4.952093556    92  C ZAS I 262168 + 8 [0] <262168>
252,0   16       21     4.952110137 19072  Q ZAS I 262144 + 8 [dd]
252,0   16       22     4.952113022 19072  G ZAS I 262144 + 8 [dd]
252,0   16       23     4.952114855 19072  I ZAS I 262144 + 8 [dd]
252,0   16       24     4.952127068  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       25     4.952141395    92  C ZAS I 262176 + 8 [0] <262176>
252,0   11        1     4.934439278 19070  Q ZAS B 262144 + 8 [dd]
252,0   11        2     4.934446191 19070  G ZAS B 262144 + 8 [dd]
252,0   11        3     4.934450258 19070  I ZAS B 262144 + 8 [dd]
252,0   11        4     4.934483481  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11        5     4.934516623    67  C ZAS B 262144 + 8 [0] <262144>
252,0   11        6     4.934547581 19070  Q ZAS B 262144 + 8 [dd]
252,0   11        7     4.934551919 19070  G ZAS B 262144 + 8 [dd]
252,0   11        8     4.934554614 19070  I ZAS B 262144 + 8 [dd]
252,0   11        9     4.934573570  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       10     4.934595230    67  C ZAS B 262152 + 8 [0] <262152>
252,0   11       11     4.934619796 19070  Q ZAS B 262144 + 8 [dd]
252,0   11       12     4.934623854 19070  G ZAS B 262144 + 8 [dd]
252,0   11       13     4.934626409 19070  I ZAS B 262144 + 8 [dd]
252,0   11       14     4.934644172  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       15     4.934664390    67  C ZAS B 262160 + 8 [0] <262160>
252,0   11       16     4.934688054 19070  Q ZAS B 262144 + 8 [dd]
252,0   11       17     4.934691972 19070  G ZAS B 262144 + 8 [dd]
252,0   11       18     4.934694547 19070  I ZAS B 262144 + 8 [dd]
252,0   11       19     4.934711629  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       20     4.934731446    67  C ZAS B 262168 + 8 [0] <262168>
252,0   11       21     4.934754770 19070  Q ZAS B 262144 + 8 [dd]
252,0   11       22     4.934758737 19070  G ZAS B 262144 + 8 [dd]
252,0   11       23     4.934761332 19070  I ZAS B 262144 + 8 [dd]
252,0   11       24     4.934778244  1363  D ZAS B 262144 + 8 [kworker/11:1H]
252,0   11       25     4.934797770    67  C ZAS B 262176 + 8 [0] <262176>
CPU4 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU10 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU11 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU16 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          15,       60KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       15,       60KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       15,       60KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 3,333KiB/s / 0KiB/s
Events (252,0): 75 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xF
---------------------------------------------
---------------------------------------------
Using Priority mask 0xF
---------------------------------------------
252,0    9        1     4.917277965 19148  Q ZAS R 262144 + 8 [dd]
252,0    9        2     4.917284688 19148  G ZAS R 262144 + 8 [dd]
252,0    9        3     4.917288405 19148  I ZAS R 262144 + 8 [dd]
252,0    9        4     4.917318701   799  D ZAS R 262144 + 8 [kworker/9:1H]
252,0    9        5     4.917364898    57  C ZAS R 262144 + 8 [0] <262144>
252,0    9        6     4.917394353 19148  Q ZAS R 262144 + 8 [dd]
252,0    9        7     4.917398461 19148  G ZAS R 262144 + 8 [dd]
252,0    9        8     4.917401006 19148  I ZAS R 262144 + 8 [dd]
252,0    9        9     4.917418729   799  D ZAS R 262144 + 8 [kworker/9:1H]
252,0    9       10     4.917461098    57  C ZAS R 262152 + 8 [0] <262152>
252,0   11        1     4.900008218 19146  Q ZAS N 262144 + 8 [dd]
252,0   11        2     4.900017596 19146  G ZAS N 262144 + 8 [dd]
252,0   11        3     4.900022335 19146  I ZAS N 262144 + 8 [dd]
252,0   11        4     4.900059134  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11        5     4.900106543    67  C ZAS N 262144 + 8 [0] <262144>
252,0   11        6     4.900137471 19146  Q ZAS N 262144 + 8 [dd]
252,0   11        7     4.900141458 19146  G ZAS N 262144 + 8 [dd]
252,0   11        8     4.900143973 19146  I ZAS N 262144 + 8 [dd]
252,0   11        9     4.900161907  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       10     4.900181574    67  C ZAS N 262152 + 8 [0] <262152>
252,0   11       11     4.900204076 19146  Q ZAS N 262144 + 8 [dd]
252,0   11       12     4.900207683 19146  G ZAS N 262144 + 8 [dd]
252,0   11       13     4.900210047 19146  I ZAS N 262144 + 8 [dd]
252,0   11       14     4.900226247  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       15     4.900250192    67  C ZAS N 262160 + 8 [0] <262160>
252,0   11       16     4.900300687 19146  Q ZAS N 262144 + 8 [dd]
252,0   11       17     4.900304644 19146  G ZAS N 262144 + 8 [dd]
252,0   11       18     4.900307089 19146  I ZAS N 262144 + 8 [dd]
252,0   11       19     4.900325013  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       20     4.900345020    67  C ZAS N 262168 + 8 [0] <262168>
252,0   11       21     4.900366731 19146  Q ZAS N 262144 + 8 [dd]
252,0   11       22     4.900370338 19146  G ZAS N 262144 + 8 [dd]
252,0   11       23     4.900372682 19146  I ZAS N 262144 + 8 [dd]
252,0   11       24     4.900388181  1363  D ZAS N 262144 + 8 [kworker/11:1H]
252,0   11       25     4.900406285    67  C ZAS N 262176 + 8 [0] <262176>
---------------------------------------------
Using Priority mask 0xF
---------------------------------------------
---------------------------------------------
Using Priority mask 0xF
---------------------------------------------
252,0   16        1     4.952700895 19152  Q ZAS I 262144 + 8 [dd]
252,0   16        2     4.952709220 19152  G ZAS I 262144 + 8 [dd]
252,0   16        3     4.952713538 19152  I ZAS I 262144 + 8 [dd]
252,0   16        4     4.952747532  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16        5     4.952868189    92  C ZAS I 262144 + 8 [0] <262144>
252,0   16        6     4.952914786 19152  Q ZAS I 262144 + 8 [dd]
252,0   16        7     4.952919645 19152  G ZAS I 262144 + 8 [dd]
252,0   16        8     4.952922320 19152  I ZAS I 262144 + 8 [dd]
252,0   16        9     4.952940264  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       10     4.952959450    92  C ZAS I 262152 + 8 [0] <262152>
252,0   16       11     4.952977453 19152  Q ZAS I 262144 + 8 [dd]
252,0   16       12     4.952980820 19152  G ZAS I 262144 + 8 [dd]
252,0   16       13     4.952982703 19152  I ZAS I 262144 + 8 [dd]
252,0   16       14     4.952995447  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       15     4.953010175    92  C ZAS I 262160 + 8 [0] <262160>
252,0   16       16     4.953027297 19152  Q ZAS I 262144 + 8 [dd]
252,0   16       17     4.953030112 19152  G ZAS I 262144 + 8 [dd]
252,0   16       18     4.953031936 19152  I ZAS I 262144 + 8 [dd]
252,0   16       19     4.953044259  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       20     4.953058636    92  C ZAS I 262168 + 8 [0] <262168>
252,0   16       21     4.953075197 19152  Q ZAS I 262144 + 8 [dd]
252,0   16       22     4.953078012 19152  G ZAS I 262144 + 8 [dd]
252,0   16       23     4.953079886 19152  I ZAS I 262144 + 8 [dd]
252,0   16       24     4.953092068  1728  D ZAS I 262144 + 8 [kworker/16:1H]
252,0   16       25     4.953106285    92  C ZAS I 262176 + 8 [0] <262176>
252,0    9       11     4.917551618 19148  Q ZAS R 262144 + 8 [dd]
252,0    9       12     4.917555996 19148  G ZAS R 262144 + 8 [dd]
252,0    9       13     4.917558701 19148  I ZAS R 262144 + 8 [dd]
252,0    9       14     4.917577086   799  D ZAS R 262144 + 8 [kworker/9:1H]
252,0    9       15     4.917598196    57  C ZAS R 262160 + 8 [0] <262160>
252,0    9       16     4.917631789 19148  Q ZAS R 262144 + 8 [dd]
252,0    9       17     4.917635516 19148  G ZAS R 262144 + 8 [dd]
252,0    9       18     4.917637930 19148  I ZAS R 262144 + 8 [dd]
252,0    9       19     4.917654431   799  D ZAS R 262144 + 8 [kworker/9:1H]
252,0    9       20     4.917673527    57  C ZAS R 262168 + 8 [0] <262168>
252,0    9       21     4.918283871 19148  Q ZAS R 262144 + 8 [dd]
252,0    9       22     4.918288941 19148  G ZAS R 262144 + 8 [dd]
252,0    9       23     4.918291916 19148  I ZAS R 262144 + 8 [dd]
252,0    9       24     4.918314108   799  D ZAS R 262144 + 8 [kworker/9:1H]
252,0    9       25     4.918337502    57  C ZAS R 262176 + 8 [0] <262176>
252,0   22        1     4.935212037 19150  Q ZAS B 262144 + 8 [dd]
252,0   22        2     4.935223038 19150  G ZAS B 262144 + 8 [dd]
252,0   22        3     4.935227917 19150  I ZAS B 262144 + 8 [dd]
252,0   22        4     4.935299592   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22        5     4.935338925   122  C ZAS B 262144 + 8 [0] <262144>
252,0   22        6     4.935371166 19150  Q ZAS B 262144 + 8 [dd]
252,0   22        7     4.935375294 19150  G ZAS B 262144 + 8 [dd]
252,0   22        8     4.935377898 19150  I ZAS B 262144 + 8 [dd]
252,0   22        9     4.935396183   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       10     4.935418054   122  C ZAS B 262152 + 8 [0] <262152>
252,0   22       11     4.935440406 19150  Q ZAS B 262144 + 8 [dd]
252,0   22       12     4.935443972 19150  G ZAS B 262144 + 8 [dd]
252,0   22       13     4.935446377 19150  I ZAS B 262144 + 8 [dd]
252,0   22       14     4.935462497   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       15     4.935481593   122  C ZAS B 262160 + 8 [0] <262160>
252,0   22       16     4.935503314 19150  Q ZAS B 262144 + 8 [dd]
252,0   22       17     4.935506960 19150  G ZAS B 262144 + 8 [dd]
252,0   22       18     4.935509345 19150  I ZAS B 262144 + 8 [dd]
252,0   22       19     4.935524954   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       20     4.935543579   122  C ZAS B 262168 + 8 [0] <262168>
252,0   22       21     4.935564589 19150  Q ZAS B 262144 + 8 [dd]
252,0   22       22     4.935568075 19150  G ZAS B 262144 + 8 [dd]
252,0   22       23     4.935570510 19150  I ZAS B 262144 + 8 [dd]
252,0   22       24     4.935588053   934  D ZAS B 262144 + 8 [kworker/22:1H]
252,0   22       25     4.935606467   122  C ZAS B 262176 + 8 [0] <262176>
CPU8 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU9 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU11 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU16 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU22 (252,0):
 Reads Queued:           5,       20KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,       20KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,       20KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          20,       80KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       20,       80KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       20,       80KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 4,444KiB/s / 0KiB/s
Events (252,0): 100 entries
Skips: 0 forward (0 -   0.0%)

#######################################################################
* Zone Management operation log Zone-Open, Zone-Close, Zone-Finish,
  Zone-Reset-All with all the priority masks :-
#######################################################################
 
---------------------------------------------
Using Priority mask 0x1
---------------------------------------------
252,0    5        1     2.898266816 12517  Q ZOS N 0 + 0 [blkzone]
252,0    5        2     2.898276374 12517  G ZOS N 0 + 0 [blkzone]
252,0    5        3     2.898280061 12517  I ZOS N 0 + 0 [blkzone]
252,0    5        4     2.898311961  1507  D ZOS N 0 + 0 [kworker/5:1H]
252,0    5        5     2.898335094    37  C ZOS N 0 + 0 [0]
252,0    5        6     2.898348870 12517  Q ZOS N 524288 + 0 [blkzone]
252,0    5        7     2.898352587 12517  G ZOS N 524288 + 0 [blkzone]
252,0    5        8     2.898354731 12517  I ZOS N 524288 + 0 [blkzone]
252,0    5        9     2.898369930  1507  D ZOS N 524288 + 0 [kworker/5:1H]
252,0    5       10     2.898383355    37  C ZOS N 524288 + 0 [0]
252,0    5       11     2.898392853 12517  Q ZOS N 1048576 + 0 [blkzone]
252,0    5       12     2.898396490 12517  G ZOS N 1048576 + 0 [blkzone]
252,0    5       13     2.898398563 12517  I ZOS N 1048576 + 0 [blkzone]
252,0    5       14     2.898412459  1507  D ZOS N 1048576 + 0 [kworker/5:1H]
252,0    5       15     2.898425033    37  C ZOS N 1048576 + 0 [0]
252,0    5       16     2.898433930 12517  Q ZOS N 1572864 + 0 [blkzone]
252,0    5       17     2.898437396 12517  G ZOS N 1572864 + 0 [blkzone]
252,0    5       18     2.898439430 12517  I ZOS N 1572864 + 0 [blkzone]
252,0    5       19     2.898452004  1507  D ZOS N 1572864 + 0 [kworker/5:1H]
252,0    5       20     2.898464347    37  C ZOS N 1572864 + 0 [0]
252,0    9        1     2.907906574 12518  Q ZCS N 0 + 0 [blkzone]
252,0    9        2     2.907913768 12518  G ZCS N 0 + 0 [blkzone]
252,0    9        3     2.907917144 12518  I ZCS N 0 + 0 [blkzone]
252,0    9        4     2.907951438   799  D ZCS N 0 + 0 [kworker/9:1H]
252,0    9        5     2.907975363    57  C ZCS N 0 + 0 [0]
252,0    9        6     2.907989720 12518  Q ZCS N 524288 + 0 [blkzone]
252,0    9        7     2.907994108 12518  G ZCS N 524288 + 0 [blkzone]
252,0    9        8     2.907996443 12518  I ZCS N 524288 + 0 [blkzone]
252,0    9        9     2.908015589   799  D ZCS N 524288 + 0 [kworker/9:1H]
252,0    9       10     2.908030497    57  C ZCS N 524288 + 0 [0]
252,0    9       11     2.908041187 12518  Q ZCS N 1048576 + 0 [blkzone]
252,0    9       12     2.908052618 12518  G ZCS N 1048576 + 0 [blkzone]
252,0    9       13     2.908079939 12518  I ZCS N 1048576 + 0 [blkzone]
252,0    9       14     2.908099286   799  D ZCS N 1048576 + 0 [kworker/9:1H]
252,0    9       15     2.908114544    57  C ZCS N 1048576 + 0 [0]
252,0    9       16     2.908125415 12518  Q ZCS N 1572864 + 0 [blkzone]
252,0    9       17     2.908129652 12518  G ZCS N 1572864 + 0 [blkzone]
252,0    9       18     2.908131857 12518  I ZCS N 1572864 + 0 [blkzone]
252,0    9       19     2.908146965   799  D ZCS N 1572864 + 0 [kworker/9:1H]
252,0    9       20     2.908160560    57  C ZCS N 1572864 + 0 [0]
252,0    3        1     2.889015547 12516  Q ZRAS N 0 + 0 [blkzone]
252,0    3        2     2.889027510 12516  G ZRAS N 0 + 0 [blkzone]
252,0    3        3     2.889031267 12516  I ZRAS N 0 + 0 [blkzone]
252,0    3        4     2.889089746  1737  D ZRAS N 0 + 0 [kworker/3:1H]
252,0    3        5     2.889118200    27  C ZRAS N 0 + 0 [0]
252,0    6        1     2.917778427 12520  Q ZFS N 0 + 0 [blkzone]
252,0    6        2     2.917785991 12520  G ZFS N 0 + 0 [blkzone]
252,0    6        3     2.917789247 12520  I ZFS N 0 + 0 [blkzone]
252,0    6        4     2.917819614   814  D ZFS N 0 + 0 [kworker/6:1H]
252,0    6        5     2.917842177    42  C ZFS N 0 + 0 [0]
252,0    6        6     2.917899835 12520  Q ZFS N 524288 + 0 [blkzone]
252,0    6        7     2.917904233 12520  G ZFS N 524288 + 0 [blkzone]
252,0    6        8     2.917906658 12520  I ZFS N 524288 + 0 [blkzone]
252,0    6        9     2.917923599   814  D ZFS N 524288 + 0 [kworker/6:1H]
252,0    6       10     2.917938658    42  C ZFS N 524288 + 0 [0]
252,0    6       11     2.917949107 12520  Q ZFS N 1048576 + 0 [blkzone]
252,0    6       12     2.917952834 12520  G ZFS N 1048576 + 0 [blkzone]
252,0    6       13     2.917954988 12520  I ZFS N 1048576 + 0 [blkzone]
252,0    6       14     2.917969976   814  D ZFS N 1048576 + 0 [kworker/6:1H]
252,0    6       15     2.917985576    42  C ZFS N 1048576 + 0 [0]
252,0    6       16     2.917996787 12520  Q ZFS N 1572864 + 0 [blkzone]
252,0    6       17     2.918000403 12520  G ZFS N 1572864 + 0 [blkzone]
252,0    6       18     2.918002497 12520  I ZFS N 1572864 + 0 [blkzone]
252,0    6       19     2.918016764   814  D ZFS N 1572864 + 0 [kworker/6:1H]
252,0    6       20     2.918029398    42  C ZFS N 1572864 + 0 [0]
CPU3 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU5 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU6 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU9 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          13,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       13,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       13,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 65 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x2
---------------------------------------------
252,0    7        1     2.959237347 12613  Q ZFS R 0 + 0 [blkzone]
252,0    7        2     2.959244520 12613  G ZFS R 0 + 0 [blkzone]
252,0    7        3     2.959247486 12613  I ZFS R 0 + 0 [blkzone]
252,0    7        4     2.959276620   828  D ZFS R 0 + 0 [kworker/7:1H]
252,0    7        5     2.959297389    47  C ZFS R 0 + 0 [0]
252,0    7        6     2.959310183 12613  Q ZFS R 524288 + 0 [blkzone]
252,0    7        7     2.959314051 12613  G ZFS R 524288 + 0 [blkzone]
252,0    7        8     2.959316195 12613  I ZFS R 524288 + 0 [blkzone]
252,0    7        9     2.959331253   828  D ZFS R 524288 + 0 [kworker/7:1H]
252,0    7       10     2.959344568    47  C ZFS R 524288 + 0 [0]
252,0    7       11     2.959353865 12613  Q ZFS R 1048576 + 0 [blkzone]
252,0    7       12     2.959357652 12613  G ZFS R 1048576 + 0 [blkzone]
252,0    7       13     2.959359646 12613  I ZFS R 1048576 + 0 [blkzone]
252,0    7       14     2.959373602   828  D ZFS R 1048576 + 0 [kworker/7:1H]
252,0    7       15     2.959386116    47  C ZFS R 1048576 + 0 [0]
252,0    7       16     2.959395173 12613  Q ZFS R 1572864 + 0 [blkzone]
252,0    7       17     2.959398800 12613  G ZFS R 1572864 + 0 [blkzone]
252,0    7       18     2.959400863 12613  I ZFS R 1572864 + 0 [blkzone]
252,0    7       19     2.959413517   828  D ZFS R 1572864 + 0 [kworker/7:1H]
252,0    7       20     2.959426001    47  C ZFS R 1572864 + 0 [0]
252,0   40        1     2.940149110 12611  Q ZOS R 0 + 0 [blkzone]
252,0   40        2     2.940156834 12611  G ZOS R 0 + 0 [blkzone]
252,0   40        3     2.940160311 12611  I ZOS R 0 + 0 [blkzone]
252,0   40        4     2.940191630  1058  D ZOS R 0 + 0 [kworker/40:1H]
252,0   40        5     2.940214603   212  C ZOS R 0 + 0 [0]
252,0   40        6     2.940228208 12611  Q ZOS R 524288 + 0 [blkzone]
252,0   40        7     2.940232747 12611  G ZOS R 524288 + 0 [blkzone]
252,0   40        8     2.940235091 12611  I ZOS R 524288 + 0 [blkzone]
252,0   40        9     2.940251612  1058  D ZOS R 524288 + 0 [kworker/40:1H]
252,0   40       10     2.940266871   212  C ZOS R 524288 + 0 [0]
252,0   40       11     2.940277481 12611  Q ZOS R 1048576 + 0 [blkzone]
252,0   40       12     2.940281638 12611  G ZOS R 1048576 + 0 [blkzone]
252,0   40       13     2.940283863 12611  I ZOS R 1048576 + 0 [blkzone]
252,0   40       14     2.940299622  1058  D ZOS R 1048576 + 0 [kworker/40:1H]
252,0   40       15     2.940313869   212  C ZOS R 1048576 + 0 [0]
252,0   40       16     2.940323848 12611  Q ZOS R 1572864 + 0 [blkzone]
252,0   40       17     2.940327675 12611  G ZOS R 1572864 + 0 [blkzone]
252,0   40       18     2.940329859 12611  I ZOS R 1572864 + 0 [blkzone]
252,0   40       19     2.940343625  1058  D ZOS R 1572864 + 0 [kworker/40:1H]
252,0   40       20     2.940357421   212  C ZOS R 1572864 + 0 [0]
252,0    3        1     2.949982471 12612  Q ZCS R 0 + 0 [blkzone]
252,0    3        2     2.949996277 12612  G ZCS R 0 + 0 [blkzone]
252,0    3        3     2.950000444 12612  I ZCS R 0 + 0 [blkzone]
252,0    3        4     2.950040259  1737  D ZCS R 0 + 0 [kworker/3:1H]
252,0    3        5     2.950066679    27  C ZCS R 0 + 0 [0]
252,0    3        6     2.950083140 12612  Q ZCS R 524288 + 0 [blkzone]
252,0    3        7     2.950087418 12612  G ZCS R 524288 + 0 [blkzone]
252,0    3        8     2.950089852 12612  I ZCS R 524288 + 0 [blkzone]
252,0    3        9     2.950106994  1737  D ZCS R 524288 + 0 [kworker/3:1H]
252,0    3       10     2.950121281    27  C ZCS R 524288 + 0 [0]
252,0    3       11     2.950131500 12612  Q ZCS R 1048576 + 0 [blkzone]
252,0    3       12     2.950135518 12612  G ZCS R 1048576 + 0 [blkzone]
252,0    3       13     2.950137712 12612  I ZCS R 1048576 + 0 [blkzone]
252,0    3       14     2.950153732  1737  D ZCS R 1048576 + 0 [kworker/3:1H]
252,0    3       15     2.950167287    27  C ZCS R 1048576 + 0 [0]
252,0    3       16     2.950177046 12612  Q ZCS R 1572864 + 0 [blkzone]
252,0    3       17     2.950180883 12612  G ZCS R 1572864 + 0 [blkzone]
252,0    3       18     2.950183077 12612  I ZCS R 1572864 + 0 [blkzone]
252,0    3       19     2.950197684  1737  D ZCS R 1572864 + 0 [kworker/3:1H]
252,0    3       20     2.950210969    27  C ZCS R 1572864 + 0 [0]
252,0    8        1     2.930841495 12610  Q ZRAS R 0 + 0 [blkzone]
252,0    8        2     2.930848448 12610  G ZRAS R 0 + 0 [blkzone]
252,0    8        3     2.930851023 12610  I ZRAS R 0 + 0 [blkzone]
252,0    8        4     2.930876120  1721  D ZRAS R 0 + 0 [kworker/8:1H]
252,0    8        5     2.930895647    52  C ZRAS R 0 + 0 [0]
CPU3 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU7 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU8 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU17 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU40 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          13,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       13,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       13,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 65 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x3
---------------------------------------------
252,0    4        1     2.910116208 12698  Q ZOS N 0 + 0 [blkzone]
252,0    4        2     2.910125986 12698  G ZOS N 0 + 0 [blkzone]
252,0    4        3     2.910129643 12698  I ZOS N 0 + 0 [blkzone]
252,0    4        4     2.910163496   968  D ZOS N 0 + 0 [kworker/4:1H]
252,0    4        5     2.910187712    32  C ZOS N 0 + 0 [0]
252,0    3        1     2.901148380 12697  Q ZRAS N 0 + 0 [blkzone]
252,0    3        2     2.901167175 12697  G ZRAS N 0 + 0 [blkzone]
252,0    3        3     2.901171393 12697  I ZRAS N 0 + 0 [blkzone]
252,0    3        4     2.901213773  1737  D ZRAS N 0 + 0 [kworker/3:1H]
252,0    3        5     2.901243749    27  C ZRAS N 0 + 0 [0]
252,0    4        6     2.910269625 12698  Q ZOS N 524288 + 0 [blkzone]
252,0    4        7     2.910274935 12698  G ZOS N 524288 + 0 [blkzone]
252,0    4        8     2.910277380 12698  I ZOS N 524288 + 0 [blkzone]
252,0    4        9     2.910295093   968  D ZOS N 524288 + 0 [kworker/4:1H]
252,0    4       10     2.910314219    32  C ZOS N 524288 + 0 [0]
252,0    4       11     2.910325460 12698  Q ZOS N 1048576 + 0 [blkzone]
252,0    4       12     2.910329177 12698  G ZOS N 1048576 + 0 [blkzone]
252,0    4       13     2.910331411 12698  I ZOS N 1048576 + 0 [blkzone]
252,0    4       14     2.910346149   968  D ZOS N 1048576 + 0 [kworker/4:1H]
252,0    4       15     2.910359674    32  C ZOS N 1048576 + 0 [0]
252,0    4       16     2.910368861 12698  Q ZOS N 1572864 + 0 [blkzone]
252,0    4       17     2.910372358 12698  G ZOS N 1572864 + 0 [blkzone]
252,0    4       18     2.910374422 12698  I ZOS N 1572864 + 0 [blkzone]
252,0    4       19     2.910387406   968  D ZOS N 1572864 + 0 [kworker/4:1H]
252,0    4       20     2.910399589    32  C ZOS N 1572864 + 0 [0]
252,0   17        1     2.946852150 12703  Q ZOS R 0 + 0 [blkzone]
252,0   17        2     2.946865545 12703  G ZOS R 0 + 0 [blkzone]
252,0   17        3     2.946870063 12703  I ZOS R 0 + 0 [blkzone]
252,0   17        4     2.946904588  1633  D ZOS R 0 + 0 [kworker/17:1H]
252,0   17        5     2.946930326    97  C ZOS R 0 + 0 [0]
252,0   17        6     2.946946296 12703  Q ZOS R 524288 + 0 [blkzone]
252,0   17        7     2.946949983 12703  G ZOS R 524288 + 0 [blkzone]
252,0   17        8     2.946952167 12703  I ZOS R 524288 + 0 [blkzone]
252,0   17        9     2.946967045  1633  D ZOS R 524288 + 0 [kworker/17:1H]
252,0   17       10     2.946980300    97  C ZOS R 524288 + 0 [0]
252,0   17       11     2.946989658 12703  Q ZOS R 1048576 + 0 [blkzone]
252,0   17       12     2.946993455 12703  G ZOS R 1048576 + 0 [blkzone]
252,0   17       13     2.946995549 12703  I ZOS R 1048576 + 0 [blkzone]
252,0   17       14     2.947009164  1633  D ZOS R 1048576 + 0 [kworker/17:1H]
252,0   17       15     2.947022088    97  C ZOS R 1048576 + 0 [0]
252,0   17       16     2.947031055 12703  Q ZOS R 1572864 + 0 [blkzone]
252,0   17       17     2.947034632 12703  G ZOS R 1572864 + 0 [blkzone]
252,0   17       18     2.947036646 12703  I ZOS R 1572864 + 0 [blkzone]
252,0   17       19     2.947049290  1633  D ZOS R 1572864 + 0 [kworker/17:1H]
252,0   17       20     2.947061693    97  C ZOS R 1572864 + 0 [0]
252,0   21        1     2.920118335 12699  Q ZCS N 0 + 0 [blkzone]
252,0   21        2     2.920125388 12699  G ZCS N 0 + 0 [blkzone]
252,0   21        3     2.920128534 12699  I ZCS N 0 + 0 [blkzone]
252,0   21        4     2.920159482   921  D ZCS N 0 + 0 [kworker/21:1H]
252,0   21        5     2.920179760   117  C ZCS N 0 + 0 [0]
252,0   21        6     2.920204016 12699  Q ZCS N 524288 + 0 [blkzone]
252,0   21        7     2.920208073 12699  G ZCS N 524288 + 0 [blkzone]
252,0   21        8     2.920210237 12699  I ZCS N 524288 + 0 [blkzone]
252,0   21        9     2.920226718   921  D ZCS N 524288 + 0 [kworker/21:1H]
252,0   21       10     2.920240163   117  C ZCS N 524288 + 0 [0]
252,0   21       11     2.920249992 12699  Q ZCS N 1048576 + 0 [blkzone]
252,0   21       12     2.920253799 12699  G ZCS N 1048576 + 0 [blkzone]
252,0   21       13     2.920255943 12699  I ZCS N 1048576 + 0 [blkzone]
252,0   21       14     2.920270951   921  D ZCS N 1048576 + 0 [kworker/21:1H]
252,0   21       15     2.920283595   117  C ZCS N 1048576 + 0 [0]
252,0   21       16     2.920292552 12699  Q ZCS N 1572864 + 0 [blkzone]
252,0   21       17     2.920296128 12699  G ZCS N 1572864 + 0 [blkzone]
252,0   21       18     2.920298162 12699  I ZCS N 1572864 + 0 [blkzone]
252,0   21       19     2.920311898   921  D ZCS N 1572864 + 0 [kworker/21:1H]
252,0   21       20     2.920324241   117  C ZCS N 1572864 + 0 [0]
252,0   21       21     2.927868419 12701  Q ZFS N 0 + 0 [blkzone]
252,0   21       22     2.927873388 12701  G ZFS N 0 + 0 [blkzone]
252,0   21       23     2.927875723 12701  I ZFS N 0 + 0 [blkzone]
252,0   21       24     2.927895460   921  D ZFS N 0 + 0 [kworker/21:1H]
252,0   21       25     2.927909376   117  C ZFS N 0 + 0 [0]
252,0   21       26     2.927918703 12701  Q ZFS N 524288 + 0 [blkzone]
252,0   21       27     2.927921699 12701  G ZFS N 524288 + 0 [blkzone]
252,0   21       28     2.927923352 12701  I ZFS N 524288 + 0 [blkzone]
252,0   21       29     2.927934793   921  D ZFS N 524288 + 0 [kworker/21:1H]
252,0   21       30     2.927945113   117  C ZFS N 524288 + 0 [0]
252,0   21       31     2.927952477 12701  Q ZFS N 1048576 + 0 [blkzone]
252,0   21       32     2.927955322 12701  G ZFS N 1048576 + 0 [blkzone]
252,0   21       33     2.927956895 12701  I ZFS N 1048576 + 0 [blkzone]
252,0   21       34     2.927967535   921  D ZFS N 1048576 + 0 [kworker/21:1H]
252,0   21       35     2.927977363   117  C ZFS N 1048576 + 0 [0]
252,0   21       36     2.927984276 12701  Q ZFS N 1572864 + 0 [blkzone]
252,0   21       37     2.927986941 12701  G ZFS N 1572864 + 0 [blkzone]
252,0   21       38     2.927988474 12701  I ZFS N 1572864 + 0 [blkzone]
252,0   21       39     2.927998142   921  D ZFS N 1572864 + 0 [kworker/21:1H]
252,0   21       40     2.928007660   117  C ZFS N 1572864 + 0 [0]
252,0   23        1     2.937071909 12702  Q ZRAS R 0 + 0 [blkzone]
252,0   23        2     2.937079783 12702  G ZRAS R 0 + 0 [blkzone]
252,0   23        3     2.937082889 12702  I ZRAS R 0 + 0 [blkzone]
252,0   23        4     2.937114659  1062  D ZRAS R 0 + 0 [kworker/23:1H]
252,0   23        5     2.937139165   127  C ZRAS R 0 + 0 [0]
252,0   32        1     2.956843607 12704  Q ZCS R 0 + 0 [blkzone]
252,0   32        2     2.956850710 12704  G ZCS R 0 + 0 [blkzone]
252,0   32        3     2.956854007 12704  I ZCS R 0 + 0 [blkzone]
252,0   32        4     2.956887529  1048  D ZCS R 0 + 0 [kworker/32:1H]
252,0   32        5     2.956909831   172  C ZCS R 0 + 0 [0]
252,0   32        6     2.956923407 12704  Q ZCS R 524288 + 0 [blkzone]
252,0   32        7     2.956927454 12704  G ZCS R 524288 + 0 [blkzone]
252,0   32        8     2.956929809 12704  I ZCS R 524288 + 0 [blkzone]
252,0   32        9     2.956947221  1048  D ZCS R 524288 + 0 [kworker/32:1H]
252,0   32       10     2.956961298   172  C ZCS R 524288 + 0 [0]
252,0   32       11     2.956971687 12704  Q ZCS R 1048576 + 0 [blkzone]
252,0   32       12     2.956975675 12704  G ZCS R 1048576 + 0 [blkzone]
252,0   32       13     2.957011642 12704  I ZCS R 1048576 + 0 [blkzone]
252,0   32       14     2.957031049  1048  D ZCS R 1048576 + 0 [kworker/32:1H]
252,0   32       15     2.957045656   172  C ZCS R 1048576 + 0 [0]
252,0   32       16     2.957056677 12704  Q ZCS R 1572864 + 0 [blkzone]
252,0   32       17     2.957061065 12704  G ZCS R 1572864 + 0 [blkzone]
252,0   32       18     2.957063359 12704  I ZCS R 1572864 + 0 [blkzone]
252,0   32       19     2.957078387  1048  D ZCS R 1572864 + 0 [kworker/32:1H]
252,0   32       20     2.957091742   172  C ZCS R 1572864 + 0 [0]
252,0    5        1     2.964527216 12705  Q ZFS R 0 + 0 [blkzone]
252,0    5        2     2.964533388 12705  G ZFS R 0 + 0 [blkzone]
252,0    5        3     2.964536003 12705  I ZFS R 0 + 0 [blkzone]
252,0    5        4     2.964561250  1507  D ZFS R 0 + 0 [kworker/5:1H]
252,0    5        5     2.964579394    37  C ZFS R 0 + 0 [0]
252,0    5        6     2.964589563 12705  Q ZFS R 524288 + 0 [blkzone]
252,0    5        7     2.964592469 12705  G ZFS R 524288 + 0 [blkzone]
252,0    5        8     2.964594172 12705  I ZFS R 524288 + 0 [blkzone]
252,0    5        9     2.964606104  1507  D ZFS R 524288 + 0 [kworker/5:1H]
252,0    5       10     2.964618047    37  C ZFS R 524288 + 0 [0]
252,0    5       11     2.964631442 12705  Q ZFS R 1048576 + 0 [blkzone]
252,0    5       12     2.964634417 12705  G ZFS R 1048576 + 0 [blkzone]
252,0    5       13     2.964636071 12705  I ZFS R 1048576 + 0 [blkzone]
252,0    5       14     2.964647803  1507  D ZFS R 1048576 + 0 [kworker/5:1H]
252,0    5       15     2.964658042    37  C ZFS R 1048576 + 0 [0]
252,0    5       16     2.964665376 12705  Q ZFS R 1572864 + 0 [blkzone]
252,0    5       17     2.964668121 12705  G ZFS R 1572864 + 0 [blkzone]
252,0    5       18     2.964669734 12705  I ZFS R 1572864 + 0 [blkzone]
252,0    5       19     2.964679793  1507  D ZFS R 1572864 + 0 [kworker/5:1H]
252,0    5       20     2.964689581    37  C ZFS R 1572864 + 0 [0]
CPU3 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU4 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU5 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU17 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           8,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        8,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        8,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU23 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU32 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          26,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       26,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       26,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 130 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x4
---------------------------------------------
252,0   16        1     3.007125693 12798  Q ZFS B 0 + 0 [blkzone]
252,0   16        2     3.007134009 12798  G ZFS B 0 + 0 [blkzone]
252,0   16        3     3.007137075 12798  I ZFS B 0 + 0 [blkzone]
252,0   16        4     3.007169385  1728  D ZFS B 0 + 0 [kworker/16:1H]
252,0   16        5     3.007194092    92  C ZFS B 0 + 0 [0]
252,0   16        6     3.007207918 12798  Q ZFS B 524288 + 0 [blkzone]
252,0   16        7     3.007211815 12798  G ZFS B 524288 + 0 [blkzone]
252,0   16        8     3.007214019 12798  I ZFS B 524288 + 0 [blkzone]
252,0   16        9     3.007229668  1728  D ZFS B 524288 + 0 [kworker/16:1H]
252,0   16       10     3.007242893    92  C ZFS B 524288 + 0 [0]
252,0   16       11     3.007252481 12798  Q ZFS B 1048576 + 0 [blkzone]
252,0   16       12     3.007256178 12798  G ZFS B 1048576 + 0 [blkzone]
252,0   16       13     3.007258252 12798  I ZFS B 1048576 + 0 [blkzone]
252,0   16       14     3.007272428  1728  D ZFS B 1048576 + 0 [kworker/16:1H]
252,0   16       15     3.007285082    92  C ZFS B 1048576 + 0 [0]
252,0   16       16     3.007294049 12798  Q ZFS B 1572864 + 0 [blkzone]
252,0   16       17     3.007297606 12798  G ZFS B 1572864 + 0 [blkzone]
252,0   16       18     3.007299660 12798  I ZFS B 1572864 + 0 [blkzone]
252,0   16       19     3.007312353  1728  D ZFS B 1572864 + 0 [kworker/16:1H]
252,0   16       20     3.007324837    92  C ZFS B 1572864 + 0 [0]
252,0   45        1     2.997947752 12797  Q ZCS B 0 + 0 [blkzone]
252,0   45        2     2.997954825 12797  G ZCS B 0 + 0 [blkzone]
252,0   45        3     2.997958021 12797  I ZCS B 0 + 0 [blkzone]
252,0   45        4     2.997988979   833  D ZCS B 0 + 0 [kworker/45:1H]
252,0   45        5     2.998010249   237  C ZCS B 0 + 0 [0]
252,0   45        6     2.998023484 12797  Q ZCS B 524288 + 0 [blkzone]
252,0   45        7     2.998027231 12797  G ZCS B 524288 + 0 [blkzone]
252,0   45        8     2.998029435 12797  I ZCS B 524288 + 0 [blkzone]
252,0   45        9     2.998045655   833  D ZCS B 524288 + 0 [kworker/45:1H]
252,0   45       10     2.998058910   237  C ZCS B 524288 + 0 [0]
252,0   45       11     2.998068488 12797  Q ZCS B 1048576 + 0 [blkzone]
252,0   45       12     2.998072225 12797  G ZCS B 1048576 + 0 [blkzone]
252,0   45       13     2.998074239 12797  I ZCS B 1048576 + 0 [blkzone]
252,0   45       14     2.998089137   833  D ZCS B 1048576 + 0 [kworker/45:1H]
252,0   45       15     2.998101610   237  C ZCS B 1048576 + 0 [0]
252,0   45       16     2.998110487 12797  Q ZCS B 1572864 + 0 [blkzone]
252,0   45       17     2.998114084 12797  G ZCS B 1572864 + 0 [blkzone]
252,0   45       18     2.998116047 12797  I ZCS B 1572864 + 0 [blkzone]
252,0   45       19     2.998129392   833  D ZCS B 1572864 + 0 [kworker/45:1H]
252,0   45       20     2.998141565   237  C ZCS B 1572864 + 0 [0]
252,0   31        1     2.988545660 12796  Q ZOS B 0 + 0 [blkzone]
252,0   31        2     2.988559195 12796  G ZOS B 0 + 0 [blkzone]
252,0   31        3     2.988563663 12796  I ZOS B 0 + 0 [blkzone]
252,0   31        4     2.988603228  1052  D ZOS B 0 + 0 [kworker/31:1H]
252,0   31        5     2.988680372   167  C ZOS B 0 + 0 [0]
252,0   31        6     2.988714626 12796  Q ZOS B 524288 + 0 [blkzone]
252,0   31        7     2.988720297 12796  G ZOS B 524288 + 0 [blkzone]
252,0   31        8     2.988722912 12796  I ZOS B 524288 + 0 [blkzone]
252,0   31        9     2.988742028  1052  D ZOS B 524288 + 0 [kworker/31:1H]
252,0   31       10     2.988758799   167  C ZOS B 524288 + 0 [0]
252,0   31       11     2.988769780 12796  Q ZOS B 1048576 + 0 [blkzone]
252,0   31       12     2.988773898 12796  G ZOS B 1048576 + 0 [blkzone]
252,0   31       13     2.988776142 12796  I ZOS B 1048576 + 0 [blkzone]
252,0   31       14     2.988792282  1052  D ZOS B 1048576 + 0 [kworker/31:1H]
252,0   31       15     2.988807220   167  C ZOS B 1048576 + 0 [0]
252,0   31       16     2.988817710 12796  Q ZOS B 1572864 + 0 [blkzone]
252,0   31       17     2.988821587 12796  G ZOS B 1572864 + 0 [blkzone]
252,0   31       18     2.988823751 12796  I ZOS B 1572864 + 0 [blkzone]
252,0   31       19     2.988838489  1052  D ZOS B 1572864 + 0 [kworker/31:1H]
252,0   31       20     2.988858126   167  C ZOS B 1572864 + 0 [0]
252,0   21        1     2.978450959 12795  Q ZRAS B 0 + 0 [blkzone]
252,0   21        2     2.978455808 12795  G ZRAS B 0 + 0 [blkzone]
252,0   21        3     2.978458443 12795  I ZRAS B 0 + 0 [blkzone]
252,0   21        4     2.978485343   921  D ZRAS B 0 + 0 [kworker/21:1H]
252,0   21        5     2.978503617   117  C ZRAS B 0 + 0 [0]
CPU16 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU31 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU34 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU45 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          13,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       13,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       13,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 65 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x5
---------------------------------------------
252,0   15        1     2.900738552 12875  Q ZRAS N 0 + 0 [blkzone]
252,0   15        2     2.900748590 12875  G ZRAS N 0 + 0 [blkzone]
252,0   15        3     2.900752778 12875  I ZRAS N 0 + 0 [blkzone]
252,0   15        4     2.900784728   827  D ZRAS N 0 + 0 [kworker/15:1H]
252,0   15        5     2.900810577    87  C ZRAS N 0 + 0 [0]
252,0   18        1     2.910619081 12876  Q ZOS N 0 + 0 [blkzone]
252,0   18        2     2.910628218 12876  G ZOS N 0 + 0 [blkzone]
252,0   18        3     2.910631775 12876  I ZOS N 0 + 0 [blkzone]
252,0   18        4     2.910695334  1007  D ZOS N 0 + 0 [kworker/18:1H]
252,0   18        5     2.910720190   102  C ZOS N 0 + 0 [0]
252,0   18        6     2.910798607 12876  Q ZOS N 524288 + 0 [blkzone]
252,0   18        7     2.910803416 12876  G ZOS N 524288 + 0 [blkzone]
252,0   18        8     2.910805851 12876  I ZOS N 524288 + 0 [blkzone]
252,0   18        9     2.910824356  1007  D ZOS N 524288 + 0 [kworker/18:1H]
252,0   18       10     2.910839174   102  C ZOS N 524288 + 0 [0]
252,0   18       11     2.910849904 12876  Q ZOS N 1048576 + 0 [blkzone]
252,0   18       12     2.910853681 12876  G ZOS N 1048576 + 0 [blkzone]
252,0   18       13     2.910855805 12876  I ZOS N 1048576 + 0 [blkzone]
252,0   18       14     2.910872005  1007  D ZOS N 1048576 + 0 [kworker/18:1H]
252,0   18       15     2.910885921   102  C ZOS N 1048576 + 0 [0]
252,0   18       16     2.910895639 12876  Q ZOS N 1572864 + 0 [blkzone]
252,0   18       17     2.910899186 12876  G ZOS N 1572864 + 0 [blkzone]
252,0   18       18     2.910901300 12876  I ZOS N 1572864 + 0 [blkzone]
252,0   18       19     2.910914425  1007  D ZOS N 1572864 + 0 [kworker/18:1H]
252,0   18       20     2.910926628   102  C ZOS N 1572864 + 0 [0]
252,0   38        1     2.922094220 12878  Q ZCS N 0 + 0 [blkzone]
252,0   38        2     2.922099200 12878  G ZCS N 0 + 0 [blkzone]
252,0   38        3     2.922101624 12878  I ZCS N 0 + 0 [blkzone]
252,0   38        4     2.922133975  1057  D ZCS N 0 + 0 [kworker/38:1H]
252,0   38        5     2.922157940   202  C ZCS N 0 + 0 [0]
252,0   38        6     2.922172477 12878  Q ZCS N 524288 + 0 [blkzone]
252,0   38        7     2.922178348 12878  G ZCS N 524288 + 0 [blkzone]
252,0   38        8     2.922180212 12878  I ZCS N 524288 + 0 [blkzone]
252,0   38        9     2.922193757  1057  D ZCS N 524288 + 0 [kworker/38:1H]
252,0   38       10     2.922207543   202  C ZCS N 524288 + 0 [0]
252,0   38       11     2.922215728 12878  Q ZCS N 1048576 + 0 [blkzone]
252,0   38       12     2.922218854 12878  G ZCS N 1048576 + 0 [blkzone]
252,0   38       13     2.922220668 12878  I ZCS N 1048576 + 0 [blkzone]
252,0   38       14     2.922235405  1057  D ZCS N 1048576 + 0 [kworker/38:1H]
252,0   38       15     2.922246446   202  C ZCS N 1048576 + 0 [0]
252,0   38       16     2.922256134 12878  Q ZCS N 1572864 + 0 [blkzone]
252,0   38       17     2.922260823 12878  G ZCS N 1572864 + 0 [blkzone]
252,0   38       18     2.922263678 12878  I ZCS N 1572864 + 0 [blkzone]
252,0   38       19     2.922276142  1057  D ZCS N 1572864 + 0 [kworker/38:1H]
252,0   38       20     2.922286932   202  C ZCS N 1572864 + 0 [0]
252,0   19        1     2.931985139 12879  Q ZFS N 0 + 0 [blkzone]
252,0   19        2     2.931992734 12879  G ZFS N 0 + 0 [blkzone]
252,0   19        3     2.931996170 12879  I ZFS N 0 + 0 [blkzone]
252,0   19        4     2.932028981  1629  D ZFS N 0 + 0 [kworker/19:1H]
252,0   19        5     2.932052015   107  C ZFS N 0 + 0 [0]
252,0   19        6     2.932066211 12879  Q ZFS N 524288 + 0 [blkzone]
252,0   19        7     2.932070289 12879  G ZFS N 524288 + 0 [blkzone]
252,0   19        8     2.932072603 12879  I ZFS N 524288 + 0 [blkzone]
252,0   19        9     2.932089245  1629  D ZFS N 524288 + 0 [kworker/19:1H]
252,0   19       10     2.932103752   107  C ZFS N 524288 + 0 [0]
252,0   19       11     2.932114372 12879  Q ZFS N 1048576 + 0 [blkzone]
252,0   19       12     2.932118329 12879  G ZFS N 1048576 + 0 [blkzone]
252,0   19       13     2.932120593 12879  I ZFS N 1048576 + 0 [blkzone]
252,0   19       14     2.932136042  1629  D ZFS N 1048576 + 0 [kworker/19:1H]
252,0   19       15     2.932149658   107  C ZFS N 1048576 + 0 [0]
252,0   19       16     2.932159596 12879  Q ZFS N 1572864 + 0 [blkzone]
252,0   19       17     2.932163534 12879  G ZFS N 1572864 + 0 [blkzone]
252,0   19       18     2.932165768 12879  I ZFS N 1572864 + 0 [blkzone]
252,0   19       19     2.932179694  1629  D ZFS N 1572864 + 0 [kworker/19:1H]
252,0   19       20     2.932193129   107  C ZFS N 1572864 + 0 [0]
252,0   18       21     2.997438897 12886  Q ZCS B 0 + 0 [blkzone]
252,0   18       22     2.997446491 12886  G ZCS B 0 + 0 [blkzone]
252,0   18       23     2.997449717 12886  I ZCS B 0 + 0 [blkzone]
252,0   18       24     2.997479172  1007  D ZCS B 0 + 0 [kworker/18:1H]
252,0   18       25     2.997499521   102  C ZCS B 0 + 0 [0]
252,0   18       26     2.997512805 12886  Q ZCS B 524288 + 0 [blkzone]
252,0   18       27     2.997516863 12886  G ZCS B 524288 + 0 [blkzone]
252,0   18       28     2.997519047 12886  I ZCS B 524288 + 0 [blkzone]
252,0   18       29     2.997535207  1007  D ZCS B 524288 + 0 [kworker/18:1H]
252,0   18       30     2.997548312   102  C ZCS B 524288 + 0 [0]
252,0   18       31     2.997557660 12886  Q ZCS B 1048576 + 0 [blkzone]
252,0   18       32     2.997561357 12886  G ZCS B 1048576 + 0 [blkzone]
252,0   18       33     2.997563420 12886  I ZCS B 1048576 + 0 [blkzone]
252,0   18       34     2.997578388  1007  D ZCS B 1048576 + 0 [kworker/18:1H]
252,0   18       35     2.997590922   102  C ZCS B 1048576 + 0 [0]
252,0   18       36     2.997599749 12886  Q ZCS B 1572864 + 0 [blkzone]
252,0   18       37     2.997603205 12886  G ZCS B 1572864 + 0 [blkzone]
252,0   18       38     2.997605189 12886  I ZCS B 1572864 + 0 [blkzone]
252,0   18       39     2.997618644  1007  D ZCS B 1572864 + 0 [kworker/18:1H]
252,0   18       40     2.997630887   102  C ZCS B 1572864 + 0 [0]
252,0   37        1     2.988474746 12885  Q ZOS B 0 + 0 [blkzone]
252,0   37        2     2.988481098 12885  G ZOS B 0 + 0 [blkzone]
252,0   37        3     2.988483723 12885  I ZOS B 0 + 0 [blkzone]
252,0   37        4     2.988511545  1060  D ZOS B 0 + 0 [kworker/37:1H]
252,0   37        5     2.988530270   197  C ZOS B 0 + 0 [0]
252,0   37        6     2.988542203 12885  Q ZOS B 524288 + 0 [blkzone]
252,0   37        7     2.988545449 12885  G ZOS B 524288 + 0 [blkzone]
252,0   37        8     2.988547312 12885  I ZOS B 524288 + 0 [blkzone]
252,0   37        9     2.988560086  1060  D ZOS B 524288 + 0 [kworker/37:1H]
252,0   37       10     2.988571357   197  C ZOS B 524288 + 0 [0]
252,0   37       11     2.988579733 12885  Q ZOS B 1048576 + 0 [blkzone]
252,0   37       12     2.988582779 12885  G ZOS B 1048576 + 0 [blkzone]
252,0   37       13     2.988584542 12885  I ZOS B 1048576 + 0 [blkzone]
252,0   37       14     2.988596264  1060  D ZOS B 1048576 + 0 [kworker/37:1H]
252,0   37       15     2.988606994   197  C ZOS B 1048576 + 0 [0]
252,0   37       16     2.988614699 12885  Q ZOS B 1572864 + 0 [blkzone]
252,0   37       17     2.988617764 12885  G ZOS B 1572864 + 0 [blkzone]
252,0   37       18     2.988620149 12885  I ZOS B 1572864 + 0 [blkzone]
252,0   37       19     2.988631109  1060  D ZOS B 1572864 + 0 [kworker/37:1H]
252,0   37       20     2.988641649   197  C ZOS B 1572864 + 0 [0]
252,0   21        1     3.005629838 12887  Q ZFS B 0 + 0 [blkzone]
252,0   21        2     3.005637242 12887  G ZFS B 0 + 0 [blkzone]
252,0   21        3     3.005640438 12887  I ZFS B 0 + 0 [blkzone]
252,0   21        4     3.005711140   921  D ZFS B 0 + 0 [kworker/21:1H]
252,0   21        5     3.005731899   117  C ZFS B 0 + 0 [0]
252,0   21        6     3.005744693 12887  Q ZFS B 524288 + 0 [blkzone]
252,0   21        7     3.005748650 12887  G ZFS B 524288 + 0 [blkzone]
252,0   21        8     3.005750714 12887  I ZFS B 524288 + 0 [blkzone]
252,0   21        9     3.005764711   921  D ZFS B 524288 + 0 [kworker/21:1H]
252,0   21       10     3.005778817   117  C ZFS B 524288 + 0 [0]
252,0   21       11     3.005788265 12887  Q ZFS B 1048576 + 0 [blkzone]
252,0   21       12     3.005791501 12887  G ZFS B 1048576 + 0 [blkzone]
252,0   21       13     3.005793565 12887  I ZFS B 1048576 + 0 [blkzone]
252,0   21       14     3.005807711   921  D ZFS B 1048576 + 0 [kworker/21:1H]
252,0   21       15     3.005818792   117  C ZFS B 1048576 + 0 [0]
252,0   21       16     3.005826717 12887  Q ZFS B 1572864 + 0 [blkzone]
252,0   21       17     3.005829732 12887  G ZFS B 1572864 + 0 [blkzone]
252,0   21       18     3.005831426 12887  I ZFS B 1572864 + 0 [blkzone]
252,0   21       19     3.005842366   921  D ZFS B 1572864 + 0 [kworker/21:1H]
252,0   21       20     3.005853006   117  C ZFS B 1572864 + 0 [0]
252,0   26        1     2.979902641 12884  Q ZRAS B 0 + 0 [blkzone]
252,0   26        2     2.979909924 12884  G ZRAS B 0 + 0 [blkzone]
252,0   26        3     2.979913210 12884  I ZRAS B 0 + 0 [blkzone]
252,0   26        4     2.979945341   830  D ZRAS B 0 + 0 [kworker/26:1H]
252,0   26        5     2.979969366   142  C ZRAS B 0 + 0 [0]
CPU15 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU18 (252,0):
 Reads Queued:           8,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        8,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        8,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU19 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU26 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU37 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU38 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          26,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       26,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       26,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 130 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x6
---------------------------------------------
252,0   35        1     2.939957711 12967  D ZRAS R 0 + 0 [systemd-udevd]
252,0   19        1     2.949385341 12970  Q ZOS R 0 + 0 [blkzone]
252,0   19        2     2.949396342 12970  G ZOS R 0 + 0 [blkzone]
252,0   19        3     2.949399968 12970  I ZOS R 0 + 0 [blkzone]
252,0   19        4     2.949434974  1629  D ZOS R 0 + 0 [kworker/19:1H]
252,0   19        5     2.949459490   107  C ZOS R 0 + 0 [0]
252,0   19        6     2.949474198 12970  Q ZOS R 524288 + 0 [blkzone]
252,0   19        7     2.949478335 12970  G ZOS R 524288 + 0 [blkzone]
252,0   19        8     2.949480540 12970  I ZOS R 524288 + 0 [blkzone]
252,0   19        9     2.949496209  1629  D ZOS R 524288 + 0 [kworker/19:1H]
252,0   19       10     2.949509544   107  C ZOS R 524288 + 0 [0]
252,0   19       11     2.949518912 12970  Q ZOS R 1048576 + 0 [blkzone]
252,0   19       12     2.949522618 12970  G ZOS R 1048576 + 0 [blkzone]
252,0   19       13     2.949524672 12970  I ZOS R 1048576 + 0 [blkzone]
252,0   19       14     2.949538929  1629  D ZOS R 1048576 + 0 [kworker/19:1H]
252,0   19       15     2.949551342   107  C ZOS R 1048576 + 0 [0]
252,0   19       16     2.949560169 12970  Q ZOS R 1572864 + 0 [blkzone]
252,0   19       17     2.949563575 12970  G ZOS R 1572864 + 0 [blkzone]
252,0   19       18     2.949565709 12970  I ZOS R 1572864 + 0 [blkzone]
252,0   19       19     2.949578373  1629  D ZOS R 1572864 + 0 [kworker/19:1H]
252,0   19       20     2.949590466   107  C ZOS R 1572864 + 0 [0]
252,0   23        1     2.939915071 12969  Q ZRAS R 0 + 0 [blkzone]
252,0   23        2     2.939922285 12969  G ZRAS R 0 + 0 [blkzone]
252,0   23        3     2.939925280 12969  I ZRAS R 0 + 0 [blkzone]
252,0   23        4     2.940001112     0  C ZRAS R 0 + 0 [0]
252,0   27        1     2.959321515 12971  Q ZCS R 0 + 0 [blkzone]
252,0   27        2     2.959329971 12971  G ZCS R 0 + 0 [blkzone]
252,0   27        3     2.959333557 12971  I ZCS R 0 + 0 [blkzone]
252,0   27        4     2.959366729   815  D ZCS R 0 + 0 [kworker/27:1H]
252,0   27        5     2.959389332   147  C ZCS R 0 + 0 [0]
252,0   27        6     2.959403138 12971  Q ZCS R 524288 + 0 [blkzone]
252,0   27        7     2.959407356 12971  G ZCS R 524288 + 0 [blkzone]
252,0   27        8     2.959409510 12971  I ZCS R 524288 + 0 [blkzone]
252,0   27        9     2.959425770   815  D ZCS R 524288 + 0 [kworker/27:1H]
252,0   27       10     2.959439366   147  C ZCS R 524288 + 0 [0]
252,0   27       11     2.959448944 12971  Q ZCS R 1048576 + 0 [blkzone]
252,0   27       12     2.959452671 12971  G ZCS R 1048576 + 0 [blkzone]
252,0   27       13     2.959454674 12971  I ZCS R 1048576 + 0 [blkzone]
252,0   27       14     2.959469632   815  D ZCS R 1048576 + 0 [kworker/27:1H]
252,0   27       15     2.959483238   147  C ZCS R 1048576 + 0 [0]
252,0   27       16     2.959492225 12971  Q ZCS R 1572864 + 0 [blkzone]
252,0   27       17     2.959495671 12971  G ZCS R 1572864 + 0 [blkzone]
252,0   27       18     2.959497735 12971  I ZCS R 1572864 + 0 [blkzone]
252,0   27       19     2.959511230   815  D ZCS R 1572864 + 0 [kworker/27:1H]
252,0   27       20     2.959523844   147  C ZCS R 1572864 + 0 [0]
252,0   32        1     2.989686078 12975  Q ZCS B 0 + 0 [blkzone]
252,0   32        2     2.989697059 12975  G ZCS B 0 + 0 [blkzone]
252,0   32        3     2.989698912 12975  I ZCS B 0 + 0 [blkzone]
252,0   32        4     2.989719170  1048  D ZCS B 0 + 0 [kworker/32:1H]
252,0   32        5     2.989733457   172  C ZCS B 0 + 0 [0]
252,0   32        6     2.989741482 12975  Q ZCS B 524288 + 0 [blkzone]
252,0   32        7     2.989743917 12975  G ZCS B 524288 + 0 [blkzone]
252,0   32        8     2.989745219 12975  I ZCS B 524288 + 0 [blkzone]
252,0   32        9     2.989754687  1048  D ZCS B 524288 + 0 [kworker/32:1H]
252,0   32       10     2.989762472   172  C ZCS B 524288 + 0 [0]
252,0   32       11     2.989768333 12975  Q ZCS B 1048576 + 0 [blkzone]
252,0   32       12     2.989770587 12975  G ZCS B 1048576 + 0 [blkzone]
252,0   32       13     2.989771829 12975  I ZCS B 1048576 + 0 [blkzone]
252,0   32       14     2.989780616  1048  D ZCS B 1048576 + 0 [kworker/32:1H]
252,0   32       15     2.989788220   172  C ZCS B 1048576 + 0 [0]
252,0   32       16     2.989793730 12975  Q ZCS B 1572864 + 0 [blkzone]
252,0   32       17     2.989795894 12975  G ZCS B 1572864 + 0 [blkzone]
252,0   32       18     2.989797147 12975  I ZCS B 1572864 + 0 [blkzone]
252,0   32       19     2.989805222  1048  D ZCS B 1572864 + 0 [kworker/32:1H]
252,0   32       20     2.989812746   172  C ZCS B 1572864 + 0 [0]
252,0   39        1     2.997933114 12976  Q ZFS B 0 + 0 [blkzone]
252,0   39        2     2.997939967 12976  G ZFS B 0 + 0 [blkzone]
252,0   39        3     2.997942502 12976  I ZFS B 0 + 0 [blkzone]
252,0   39        4     2.997971306   533  D ZFS B 0 + 0 [kworker/39:1H]
252,0   39        5     2.997990983   207  C ZFS B 0 + 0 [0]
252,0   39        6     2.998002775 12976  Q ZFS B 524288 + 0 [blkzone]
252,0   39        7     2.998006742 12976  G ZFS B 524288 + 0 [blkzone]
252,0   39        8     2.998008796 12976  I ZFS B 524288 + 0 [blkzone]
252,0   39        9     2.998021911   533  D ZFS B 524288 + 0 [kworker/39:1H]
252,0   39       10     2.998033352   207  C ZFS B 524288 + 0 [0]
252,0   39       11     2.998042540 12976  Q ZFS B 1048576 + 0 [blkzone]
252,0   39       12     2.998047138 12976  G ZFS B 1048576 + 0 [blkzone]
252,0   39       13     2.998049052 12976  I ZFS B 1048576 + 0 [blkzone]
252,0   39       14     2.998062106   533  D ZFS B 1048576 + 0 [kworker/39:1H]
252,0   39       15     2.998073307   207  C ZFS B 1048576 + 0 [0]
252,0   39       16     2.998081062 12976  Q ZFS B 1572864 + 0 [blkzone]
252,0   39       17     2.998084178 12976  G ZFS B 1572864 + 0 [blkzone]
252,0   39       18     2.998086031 12976  I ZFS B 1572864 + 0 [blkzone]
252,0   39       19     2.998097202   533  D ZFS B 1572864 + 0 [kworker/39:1H]
252,0   39       20     2.998135754   207  C ZFS B 1572864 + 0 [0]
252,0   26        1     2.968900138 12972  Q ZFS R 0 + 0 [blkzone]
252,0   26        2     2.968907922 12972  G ZFS R 0 + 0 [blkzone]
252,0   26        3     2.968911439 12972  I ZFS R 0 + 0 [blkzone]
252,0   26        4     2.968943088   830  D ZFS R 0 + 0 [kworker/26:1H]
252,0   26        5     2.968966602   142  C ZFS R 0 + 0 [0]
252,0   26        6     2.968980509 12972  Q ZFS R 524288 + 0 [blkzone]
252,0   26        7     2.968984887 12972  G ZFS R 524288 + 0 [blkzone]
252,0   26        8     2.968987221 12972  I ZFS R 524288 + 0 [blkzone]
252,0   26        9     2.969003632   830  D ZFS R 524288 + 0 [kworker/26:1H]
252,0   26       10     2.969018199   142  C ZFS R 524288 + 0 [0]
252,0   26       11     2.969028559 12972  Q ZFS R 1048576 + 0 [blkzone]
252,0   26       12     2.969032927 12972  G ZFS R 1048576 + 0 [blkzone]
252,0   26       13     2.969035231 12972  I ZFS R 1048576 + 0 [blkzone]
252,0   26       14     2.969051632   830  D ZFS R 1048576 + 0 [kworker/26:1H]
252,0   26       15     2.969065518   142  C ZFS R 1048576 + 0 [0]
252,0   26       16     2.969075527 12972  Q ZFS R 1572864 + 0 [blkzone]
252,0   26       17     2.969079394 12972  G ZFS R 1572864 + 0 [blkzone]
252,0   26       18     2.969081618 12972  I ZFS R 1572864 + 0 [blkzone]
252,0   26       19     2.969095634   830  D ZFS R 1572864 + 0 [kworker/26:1H]
252,0   26       20     2.969145077   142  C ZFS R 1572864 + 0 [0]
252,0   21        1     2.976238760 12973  Q ZRAS B 0 + 0 [blkzone]
252,0   21        2     2.976244341 12973  G ZRAS B 0 + 0 [blkzone]
252,0   21        3     2.976246875 12973  I ZRAS B 0 + 0 [blkzone]
252,0   21        4     2.976270149   921  D ZRAS B 0 + 0 [kworker/21:1H]
252,0   21        5     2.976288193   117  C ZRAS B 0 + 0 [0]
252,0   21        6     2.983078747 12974  Q ZOS B 0 + 0 [blkzone]
252,0   21        7     2.983084468 12974  G ZOS B 0 + 0 [blkzone]
252,0   21        8     2.983086843 12974  I ZOS B 0 + 0 [blkzone]
252,0   21        9     2.983129422   921  D ZOS B 0 + 0 [kworker/21:1H]
252,0   21       10     2.983144080   117  C ZOS B 0 + 0 [0]
252,0   21       11     2.983153588 12974  Q ZOS B 524288 + 0 [blkzone]
252,0   21       12     2.983156964 12974  G ZOS B 524288 + 0 [blkzone]
252,0   21       13     2.983158757 12974  I ZOS B 524288 + 0 [blkzone]
252,0   21       14     2.983171071   921  D ZOS B 524288 + 0 [kworker/21:1H]
252,0   21       15     2.983181731   117  C ZOS B 524288 + 0 [0]
252,0   21       16     2.983189074 12974  Q ZOS B 1048576 + 0 [blkzone]
252,0   21       17     2.983192070 12974  G ZOS B 1048576 + 0 [blkzone]
252,0   21       18     2.983193653 12974  I ZOS B 1048576 + 0 [blkzone]
252,0   21       19     2.983205355   921  D ZOS B 1048576 + 0 [kworker/21:1H]
252,0   21       20     2.983215855   117  C ZOS B 1048576 + 0 [0]
252,0   21       21     2.983223238 12974  Q ZOS B 1572864 + 0 [blkzone]
252,0   21       22     2.983226264 12974  G ZOS B 1572864 + 0 [blkzone]
252,0   21       23     2.983227867 12974  I ZOS B 1572864 + 0 [blkzone]
252,0   21       24     2.983237796   921  D ZOS B 1572864 + 0 [kworker/21:1H]
252,0   21       25     2.983247504   117  C ZOS B 1572864 + 0 [0]
CPU15 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU19 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           5,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU23 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU26 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU27 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU32 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU35 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU39 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          26,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       26,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       26,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 130 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x7
---------------------------------------------
252,0   16        1     2.910232165 13062  Q ZOS N 0 + 0 [blkzone]
252,0   16        2     2.910242224 13062  G ZOS N 0 + 0 [blkzone]
252,0   16        3     2.910246101 13062  I ZOS N 0 + 0 [blkzone]
252,0   16        4     2.910282129  1728  D ZOS N 0 + 0 [kworker/16:1H]
252,0   16        5     2.910310021    92  C ZOS N 0 + 0 [0]
252,0   21        1     2.900836445 13061  Q ZRAS N 0 + 0 [blkzone]
252,0   21        2     2.900846364 13061  G ZRAS N 0 + 0 [blkzone]
252,0   21        3     2.900849900 13061  I ZRAS N 0 + 0 [blkzone]
252,0   21        4     2.900882141   921  D ZRAS N 0 + 0 [kworker/21:1H]
252,0   21        5     2.900908089   117  C ZRAS N 0 + 0 [0]
252,0   19        1     2.919997298 13063  Q ZCS N 0 + 0 [blkzone]
252,0   19        2     2.920009671 13063  G ZCS N 0 + 0 [blkzone]
252,0   19        3     2.920013488 13063  I ZCS N 0 + 0 [blkzone]
252,0   19        4     2.920049987  1629  D ZCS N 0 + 0 [kworker/19:1H]
252,0   19        5     2.920074653   107  C ZCS N 0 + 0 [0]
252,0   19        6     2.920089170 13063  Q ZCS N 524288 + 0 [blkzone]
252,0   19        7     2.920093048 13063  G ZCS N 524288 + 0 [blkzone]
252,0   19        8     2.920095282 13063  I ZCS N 524288 + 0 [blkzone]
252,0   19        9     2.920111632  1629  D ZCS N 524288 + 0 [kworker/19:1H]
252,0   19       10     2.920125218   107  C ZCS N 524288 + 0 [0]
252,0   19       11     2.920134836 13063  Q ZCS N 1048576 + 0 [blkzone]
252,0   19       12     2.920138733 13063  G ZCS N 1048576 + 0 [blkzone]
252,0   19       13     2.920140777 13063  I ZCS N 1048576 + 0 [blkzone]
252,0   19       14     2.920155815  1629  D ZCS N 1048576 + 0 [kworker/19:1H]
252,0   19       15     2.920168449   107  C ZCS N 1048576 + 0 [0]
252,0   19       16     2.920177436 13063  Q ZCS N 1572864 + 0 [blkzone]
252,0   19       17     2.920180872 13063  G ZCS N 1572864 + 0 [blkzone]
252,0   19       18     2.920182866 13063  I ZCS N 1572864 + 0 [blkzone]
252,0   19       19     2.920196381  1629  D ZCS N 1572864 + 0 [kworker/19:1H]
252,0   19       20     2.920208554   107  C ZCS N 1572864 + 0 [0]
252,0   32        1     2.929146887 13065  Q ZFS N 0 + 0 [blkzone]
252,0   32        2     2.929153679 13065  G ZFS N 0 + 0 [blkzone]
252,0   32        3     2.929156234 13065  I ZFS N 0 + 0 [blkzone]
252,0   32        4     2.929180740  1048  D ZFS N 0 + 0 [kworker/32:1H]
252,0   32        5     2.929198604   172  C ZFS N 0 + 0 [0]
252,0   32        6     2.929209254 13065  Q ZFS N 524288 + 0 [blkzone]
252,0   32        7     2.929212349 13065  G ZFS N 524288 + 0 [blkzone]
252,0   32        8     2.929214103 13065  I ZFS N 524288 + 0 [blkzone]
252,0   32        9     2.929226366  1048  D ZFS N 524288 + 0 [kworker/32:1H]
252,0   32       10     2.929237076   172  C ZFS N 524288 + 0 [0]
252,0   32       11     2.929244600 13065  Q ZFS N 1048576 + 0 [blkzone]
252,0   32       12     2.929247565 13065  G ZFS N 1048576 + 0 [blkzone]
252,0   32       13     2.929249188 13065  I ZFS N 1048576 + 0 [blkzone]
252,0   32       14     2.929260419  1048  D ZFS N 1048576 + 0 [kworker/32:1H]
252,0   32       15     2.929270348   172  C ZFS N 1048576 + 0 [0]
252,0   32       16     2.929277381 13065  Q ZFS N 1572864 + 0 [blkzone]
252,0   32       17     2.929280076 13065  G ZFS N 1572864 + 0 [blkzone]
252,0   32       18     2.929281719 13065  I ZFS N 1572864 + 0 [blkzone]
252,0   32       19     2.929291638  1048  D ZFS N 1572864 + 0 [kworker/32:1H]
252,0   32       20     2.929301597   172  C ZFS N 1572864 + 0 [0]
252,0   33        1     2.946511040 13067  Q ZOS R 0 + 0 [blkzone]
252,0   33        2     2.946517903 13067  G ZOS R 0 + 0 [blkzone]
252,0   33        3     2.946520468 13067  I ZOS R 0 + 0 [blkzone]
252,0   33        4     2.946550033  1049  D ZOS R 0 + 0 [kworker/33:1H]
252,0   33        5     2.946570031   177  C ZOS R 0 + 0 [0]
252,0   33        6     2.946581362 13067  Q ZOS R 524288 + 0 [blkzone]
252,0   33        7     2.946585189 13067  G ZOS R 524288 + 0 [blkzone]
252,0   33        8     2.946587133 13067  I ZOS R 524288 + 0 [blkzone]
252,0   33        9     2.946600698  1049  D ZOS R 524288 + 0 [kworker/33:1H]
252,0   33       10     2.946613202   177  C ZOS R 524288 + 0 [0]
252,0   33       11     2.946621758 13067  Q ZOS R 1048576 + 0 [blkzone]
252,0   33       12     2.946625124 13067  G ZOS R 1048576 + 0 [blkzone]
252,0   33       13     2.946627028 13067  I ZOS R 1048576 + 0 [blkzone]
252,0   33       14     2.946638880  1049  D ZOS R 1048576 + 0 [kworker/33:1H]
252,0   33       15     2.946667974   177  C ZOS R 1048576 + 0 [0]
252,0   33       16     2.946677442 13067  Q ZOS R 1572864 + 0 [blkzone]
252,0   33       17     2.946681149 13067  G ZOS R 1572864 + 0 [blkzone]
252,0   33       18     2.946683073 13067  I ZOS R 1572864 + 0 [blkzone]
252,0   33       19     2.946696518  1049  D ZOS R 1572864 + 0 [kworker/33:1H]
252,0   33       20     2.946708070   177  C ZOS R 1572864 + 0 [0]
252,0   16        6     2.910400851 13062  Q ZOS N 524288 + 0 [blkzone]
252,0   16        7     2.910405520 13062  G ZOS N 524288 + 0 [blkzone]
252,0   16        8     2.910407915 13062  I ZOS N 524288 + 0 [blkzone]
252,0   16        9     2.910426870  1728  D ZOS N 524288 + 0 [kworker/16:1H]
252,0   16       10     2.910446327    92  C ZOS N 524288 + 0 [0]
252,0   16       11     2.910458349 13062  Q ZOS N 1048576 + 0 [blkzone]
252,0   16       12     2.910462026 13062  G ZOS N 1048576 + 0 [blkzone]
252,0   16       13     2.910464130 13062  I ZOS N 1048576 + 0 [blkzone]
252,0   16       14     2.910479238  1728  D ZOS N 1048576 + 0 [kworker/16:1H]
252,0   16       15     2.910495379    92  C ZOS N 1048576 + 0 [0]
252,0   16       16     2.910506650 13062  Q ZOS N 1572864 + 0 [blkzone]
252,0   16       17     2.910510207 13062  G ZOS N 1572864 + 0 [blkzone]
252,0   16       18     2.910512210 13062  I ZOS N 1572864 + 0 [blkzone]
252,0   16       19     2.910527529  1728  D ZOS N 1572864 + 0 [kworker/16:1H]
252,0   16       20     2.910544721    92  C ZOS N 1572864 + 0 [0]
252,0   53        1     2.938070000 13066  Q ZRAS R 0 + 0 [blkzone]
252,0   53        2     2.938077625 13066  G ZRAS R 0 + 0 [blkzone]
252,0   53        3     2.938080650 13066  I ZRAS R 0 + 0 [blkzone]
252,0   53        4     2.938111679  1092  D ZRAS R 0 + 0 [kworker/53:1H]
252,0   53        5     2.938137126   277  C ZRAS R 0 + 0 [0]
252,0   27        1     2.955151303 13068  Q ZCS R 0 + 0 [blkzone]
252,0   27        2     2.955158677 13068  G ZCS R 0 + 0 [blkzone]
252,0   27        3     2.955161753 13068  I ZCS R 0 + 0 [blkzone]
252,0   27        4     2.955193483   815  D ZCS R 0 + 0 [kworker/27:1H]
252,0   27        5     2.955216275   147  C ZCS R 0 + 0 [0]
252,0   27        6     2.955229260 13068  Q ZCS R 524288 + 0 [blkzone]
252,0   27        7     2.955233007 13068  G ZCS R 524288 + 0 [blkzone]
252,0   27        8     2.955235181 13068  I ZCS R 524288 + 0 [blkzone]
252,0   27        9     2.955251572   815  D ZCS R 524288 + 0 [kworker/27:1H]
252,0   27       10     2.955294552   147  C ZCS R 524288 + 0 [0]
252,0   27       11     2.955305944 13068  Q ZCS R 1048576 + 0 [blkzone]
252,0   27       12     2.955310432 13068  G ZCS R 1048576 + 0 [blkzone]
252,0   27       13     2.955312646 13068  I ZCS R 1048576 + 0 [blkzone]
252,0   27       14     2.955329488   815  D ZCS R 1048576 + 0 [kworker/27:1H]
252,0   27       15     2.955342512   147  C ZCS R 1048576 + 0 [0]
252,0   27       16     2.955351729 13068  Q ZCS R 1572864 + 0 [blkzone]
252,0   27       17     2.955355246 13068  G ZCS R 1572864 + 0 [blkzone]
252,0   27       18     2.955357350 13068  I ZCS R 1572864 + 0 [blkzone]
252,0   27       19     2.955370875   815  D ZCS R 1572864 + 0 [kworker/27:1H]
252,0   27       20     2.955383208   147  C ZCS R 1572864 + 0 [0]
252,0   23        1     2.965175182 13069  Q ZFS R 0 + 0 [blkzone]
252,0   23        2     2.965186663 13069  G ZFS R 0 + 0 [blkzone]
252,0   23        3     2.965191041 13069  I ZFS R 0 + 0 [blkzone]
252,0   23        4     2.965233491  1062  D ZFS R 0 + 0 [kworker/23:1H]
252,0   23        5     2.965267895   127  C ZFS R 0 + 0 [0]
252,0   34        1     3.004021201 13073  Q ZFS B 0 + 0 [blkzone]
252,0   34        2     3.004029857 13073  G ZFS B 0 + 0 [blkzone]
252,0   34        3     3.004033444 13073  I ZFS B 0 + 0 [blkzone]
252,0   34        4     3.004070042  1050  D ZFS B 0 + 0 [kworker/34:1H]
252,0   34        5     3.004098055   182  C ZFS B 0 + 0 [0]
252,0   34        6     3.004113344 13073  Q ZFS B 524288 + 0 [blkzone]
252,0   34        7     3.004117982 13073  G ZFS B 524288 + 0 [blkzone]
252,0   34        8     3.004120547 13073  I ZFS B 524288 + 0 [blkzone]
252,0   34        9     3.004138120  1050  D ZFS B 524288 + 0 [kworker/34:1H]
252,0   34       10     3.004154190   182  C ZFS B 524288 + 0 [0]
252,0   34       11     3.004165542 13073  Q ZFS B 1048576 + 0 [blkzone]
252,0   34       12     3.004169940 13073  G ZFS B 1048576 + 0 [blkzone]
252,0   34       13     3.004172424 13073  I ZFS B 1048576 + 0 [blkzone]
252,0   34       14     3.004189567  1050  D ZFS B 1048576 + 0 [kworker/34:1H]
252,0   34       15     3.004204845   182  C ZFS B 1048576 + 0 [0]
252,0   34       16     3.004215776 13073  Q ZFS B 1572864 + 0 [blkzone]
252,0   34       17     3.004219964 13073  G ZFS B 1572864 + 0 [blkzone]
252,0   34       18     3.004222368 13073  I ZFS B 1572864 + 0 [blkzone]
252,0   34       19     3.004237466  1050  D ZFS B 1572864 + 0 [kworker/34:1H]
252,0   34       20     3.004252434   182  C ZFS B 1572864 + 0 [0]
252,0   40        1     2.984253319 13071  Q ZOS B 0 + 0 [blkzone]
252,0   40        2     2.984262066 13071  G ZOS B 0 + 0 [blkzone]
252,0   40        3     2.984265232 13071  I ZOS B 0 + 0 [blkzone]
252,0   40        4     2.984298113  1058  D ZOS B 0 + 0 [kworker/40:1H]
252,0   40        5     2.984320165   212  C ZOS B 0 + 0 [0]
252,0   40        6     2.984333700 13071  Q ZOS B 524288 + 0 [blkzone]
252,0   40        7     2.984337718 13071  G ZOS B 524288 + 0 [blkzone]
252,0   40        8     2.984339852 13071  I ZOS B 524288 + 0 [blkzone]
252,0   40        9     2.984355301  1058  D ZOS B 524288 + 0 [kworker/40:1H]
252,0   40       10     2.984368876   212  C ZOS B 524288 + 0 [0]
252,0   40       11     2.984378574 13071  Q ZOS B 1048576 + 0 [blkzone]
252,0   40       12     2.984382291 13071  G ZOS B 1048576 + 0 [blkzone]
252,0   40       13     2.984384405 13071  I ZOS B 1048576 + 0 [blkzone]
252,0   40       14     2.984398742  1058  D ZOS B 1048576 + 0 [kworker/40:1H]
252,0   40       15     2.984411486   212  C ZOS B 1048576 + 0 [0]
252,0   40       16     2.984420864 13071  Q ZOS B 1572864 + 0 [blkzone]
252,0   40       17     2.984424350 13071  G ZOS B 1572864 + 0 [blkzone]
252,0   40       18     2.984426394 13071  I ZOS B 1572864 + 0 [blkzone]
252,0   40       19     2.984439208  1058  D ZOS B 1572864 + 0 [kworker/40:1H]
252,0   40       20     2.984452333   212  C ZOS B 1572864 + 0 [0]
252,0   24        1     2.994062184 13072  Q ZCS B 0 + 0 [blkzone]
252,0   24        2     2.994070079 13072  G ZCS B 0 + 0 [blkzone]
252,0   24        3     2.994073626 13072  I ZCS B 0 + 0 [blkzone]
252,0   24        4     2.994108992  1030  D ZCS B 0 + 0 [kworker/24:1H]
252,0   24        5     2.994133188   132  C ZCS B 0 + 0 [0]
252,0   24        6     2.994148276 13072  Q ZCS B 524288 + 0 [blkzone]
252,0   24        7     2.994152714 13072  G ZCS B 524288 + 0 [blkzone]
252,0   24        8     2.994155089 13072  I ZCS B 524288 + 0 [blkzone]
252,0   24        9     2.994172792  1030  D ZCS B 524288 + 0 [kworker/24:1H]
252,0   24       10     2.994187439   132  C ZCS B 524288 + 0 [0]
252,0   24       11     2.994197979 13072  Q ZCS B 1048576 + 0 [blkzone]
252,0   24       12     2.994202347 13072  G ZCS B 1048576 + 0 [blkzone]
252,0   24       13     2.994204601 13072  I ZCS B 1048576 + 0 [blkzone]
252,0   24       14     2.994220872  1030  D ZCS B 1048576 + 0 [kworker/24:1H]
252,0   24       15     2.994234778   132  C ZCS B 1048576 + 0 [0]
252,0   24       16     2.994244827 13072  Q ZCS B 1572864 + 0 [blkzone]
252,0   24       17     2.994248915 13072  G ZCS B 1572864 + 0 [blkzone]
252,0   24       18     2.994251179 13072  I ZCS B 1572864 + 0 [blkzone]
252,0   24       19     2.994265906  1030  D ZCS B 1572864 + 0 [kworker/24:1H]
252,0   24       20     2.994279582   132  C ZCS B 1572864 + 0 [0]
252,0   23        6     2.965371179 13069  Q ZFS R 524288 + 0 [blkzone]
252,0   23        7     2.965377050 13069  G ZFS R 524288 + 0 [blkzone]
252,0   23        8     2.965379926 13069  I ZFS R 524288 + 0 [blkzone]
252,0   23        9     2.965401135  1062  D ZFS R 524288 + 0 [kworker/23:1H]
252,0   23       10     2.965417366   127  C ZFS R 524288 + 0 [0]
252,0   23       11     2.965429408 13069  Q ZFS R 1048576 + 0 [blkzone]
252,0   23       12     2.965433596 13069  G ZFS R 1048576 + 0 [blkzone]
252,0   23       13     2.965435850 13069  I ZFS R 1048576 + 0 [blkzone]
252,0   23       14     2.965451470  1062  D ZFS R 1048576 + 0 [kworker/23:1H]
252,0   23       15     2.965466798   127  C ZFS R 1048576 + 0 [0]
252,0   23       16     2.965478991 13069  Q ZFS R 1572864 + 0 [blkzone]
252,0   23       17     2.965482849 13069  G ZFS R 1572864 + 0 [blkzone]
252,0   23       18     2.965485093 13069  I ZFS R 1572864 + 0 [blkzone]
252,0   23       19     2.965500371  1062  D ZFS R 1572864 + 0 [kworker/23:1H]
252,0   23       20     2.965514398   127  C ZFS R 1572864 + 0 [0]
252,0   31        1     2.975383826 13070  Q ZRAS B 0 + 0 [blkzone]
252,0   31        2     2.975391230 13070  G ZRAS B 0 + 0 [blkzone]
252,0   31        3     2.975394556 13070  I ZRAS B 0 + 0 [blkzone]
252,0   31        4     2.975428670  1052  D ZRAS B 0 + 0 [kworker/31:1H]
252,0   31        5     2.975454789   167  C ZRAS B 0 + 0 [0]
CPU16 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU17 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU19 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU23 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU24 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU27 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU31 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU32 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU33 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU34 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU40 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU53 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          39,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       39,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       39,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 195 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x8
---------------------------------------------
252,0   58        1     3.018770551 13175  Q ZRAS I 0 + 0 [blkzone]
252,0   58        2     3.018776752 13175  G ZRAS I 0 + 0 [blkzone]
252,0   58        3     3.018779838 13175  I ZRAS I 0 + 0 [blkzone]
252,0    4        1     3.043778469 13178  Q ZFS I 0 + 0 [blkzone]
252,0    4        2     3.043791383 13178  G ZFS I 0 + 0 [blkzone]
252,0    4        3     3.043795481 13178  I ZFS I 0 + 0 [blkzone]
252,0    4        4     3.043831078   968  D ZFS I 0 + 0 [kworker/4:1H]
252,0    4        5     3.043857327    32  C ZFS I 0 + 0 [0]
252,0    4        6     3.043872926 13178  Q ZFS I 524288 + 0 [blkzone]
252,0    4        7     3.043876864 13178  G ZFS I 524288 + 0 [blkzone]
252,0    4        8     3.043879108 13178  I ZFS I 524288 + 0 [blkzone]
252,0    4        9     3.043894276   968  D ZFS I 524288 + 0 [kworker/4:1H]
252,0    4       10     3.043907671    32  C ZFS I 524288 + 0 [0]
252,0    4       11     3.043917099 13178  Q ZFS I 1048576 + 0 [blkzone]
252,0    4       12     3.043920896 13178  G ZFS I 1048576 + 0 [blkzone]
252,0    4       13     3.043922960 13178  I ZFS I 1048576 + 0 [blkzone]
252,0    4       14     3.043937217   968  D ZFS I 1048576 + 0 [kworker/4:1H]
252,0    4       15     3.043950111    32  C ZFS I 1048576 + 0 [0]
252,0    4       16     3.043959098 13178  Q ZFS I 1572864 + 0 [blkzone]
252,0    4       17     3.043962835 13178  G ZFS I 1572864 + 0 [blkzone]
252,0    4       18     3.043964929 13178  I ZFS I 1572864 + 0 [blkzone]
252,0    4       19     3.043977452   968  D ZFS I 1572864 + 0 [kworker/4:1H]
252,0    4       20     3.043989715    32  C ZFS I 1572864 + 0 [0]
252,0   38        1     3.018818751  1057  D ZRAS I 0 + 0 [kworker/38:1H]
252,0    2        1     3.033865359 13177  Q ZCS I 0 + 0 [blkzone]
252,0    2        2     3.033871741 13177  G ZCS I 0 + 0 [blkzone]
252,0    2        3     3.033875067 13177  I ZCS I 0 + 0 [blkzone]
252,0    2        4     3.033909010  1449  D ZCS I 0 + 0 [kworker/2:1H]
252,0    2        5     3.033931693    22  C ZCS I 0 + 0 [0]
252,0    2        6     3.033945569 13177  Q ZCS I 524288 + 0 [blkzone]
252,0    2        7     3.033949717 13177  G ZCS I 524288 + 0 [blkzone]
252,0    2        8     3.033952041 13177  I ZCS I 524288 + 0 [blkzone]
252,0    2        9     3.033969754  1449  D ZCS I 524288 + 0 [kworker/2:1H]
252,0    2       10     3.033984171    22  C ZCS I 524288 + 0 [0]
252,0    2       11     3.033994511 13177  Q ZCS I 1048576 + 0 [blkzone]
252,0    2       12     3.033998408 13177  G ZCS I 1048576 + 0 [blkzone]
252,0    2       13     3.034000602 13177  I ZCS I 1048576 + 0 [blkzone]
252,0    2       14     3.034017053  1449  D ZCS I 1048576 + 0 [kworker/2:1H]
252,0    2       15     3.034030659    22  C ZCS I 1048576 + 0 [0]
252,0    2       16     3.034040457 13177  Q ZCS I 1572864 + 0 [blkzone]
252,0    2       17     3.034044264 13177  G ZCS I 1572864 + 0 [blkzone]
252,0    2       18     3.034046418 13177  I ZCS I 1572864 + 0 [blkzone]
252,0    2       19     3.034061286  1449  D ZCS I 1572864 + 0 [kworker/2:1H]
252,0    2       20     3.034074561    22  C ZCS I 1572864 + 0 [0]
252,0   58        4     3.018840472 13155  C ZRAS I 0 + 0 [0]
252,0   58        5     3.024902019 13176  Q ZOS I 0 + 0 [blkzone]
252,0   58        6     3.024906117 13176  G ZOS I 0 + 0 [blkzone]
252,0   58        7     3.024908031 13176  I ZOS I 0 + 0 [blkzone]
252,0   58        8     3.024927718   816  D ZOS I 0 + 0 [kworker/58:1H]
252,0   58        9     3.024942205   302  C ZOS I 0 + 0 [0]
252,0   58       10     3.024950480 13176  Q ZOS I 524288 + 0 [blkzone]
252,0   58       11     3.024952674 13176  G ZOS I 524288 + 0 [blkzone]
252,0   58       12     3.024953947 13176  I ZOS I 524288 + 0 [blkzone]
252,0   58       13     3.024962904   816  D ZOS I 524288 + 0 [kworker/58:1H]
252,0   58       14     3.024970808   302  C ZOS I 524288 + 0 [0]
252,0   58       15     3.024976499 13176  Q ZOS I 1048576 + 0 [blkzone]
252,0   58       16     3.024978643 13176  G ZOS I 1048576 + 0 [blkzone]
252,0   58       17     3.024979835 13176  I ZOS I 1048576 + 0 [blkzone]
252,0   58       18     3.024988181   816  D ZOS I 1048576 + 0 [kworker/58:1H]
252,0   58       19     3.024996156   302  C ZOS I 1048576 + 0 [0]
252,0   58       20     3.025001786 13176  Q ZOS I 1572864 + 0 [blkzone]
252,0   58       21     3.025004041 13176  G ZOS I 1572864 + 0 [blkzone]
252,0   58       22     3.025005233 13176  I ZOS I 1572864 + 0 [blkzone]
252,0   58       23     3.025012847   816  D ZOS I 1572864 + 0 [kworker/58:1H]
252,0   58       24     3.025020211   302  C ZOS I 1572864 + 0 [0]
CPU2 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU4 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU15 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU38 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU58 (252,0):
 Reads Queued:           5,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          13,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       13,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       13,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 65 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0x9
---------------------------------------------
252,0   50        1     2.902435534 13252  Q ZOS N 0 + 0 [blkzone]
252,0   50        2     2.902441956 13252  G ZOS N 0 + 0 [blkzone]
252,0   50        3     2.902445152 13252  I ZOS N 0 + 0 [blkzone]
252,0   50        4     2.902476441   840  D ZOS N 0 + 0 [kworker/50:1H]
252,0   50        5     2.902498402   262  C ZOS N 0 + 0 [0]
252,0   50        6     2.902511056 13252  Q ZOS N 524288 + 0 [blkzone]
252,0   50        7     2.902514863 13252  G ZOS N 524288 + 0 [blkzone]
252,0   50        8     2.902517027 13252  I ZOS N 524288 + 0 [blkzone]
252,0   50        9     2.902532295   840  D ZOS N 524288 + 0 [kworker/50:1H]
252,0   50       10     2.902545711   262  C ZOS N 524288 + 0 [0]
252,0   50       11     2.902555058 13252  Q ZOS N 1048576 + 0 [blkzone]
252,0   50       12     2.902558955 13252  G ZOS N 1048576 + 0 [blkzone]
252,0   50       13     2.902561019 13252  I ZOS N 1048576 + 0 [blkzone]
252,0   50       14     2.902574935   840  D ZOS N 1048576 + 0 [kworker/50:1H]
252,0   50       15     2.902587309   262  C ZOS N 1048576 + 0 [0]
252,0   50       16     2.902596175 13252  Q ZOS N 1572864 + 0 [blkzone]
252,0   50       17     2.902625270 13252  G ZOS N 1572864 + 0 [blkzone]
252,0   50       18     2.902627584 13252  I ZOS N 1572864 + 0 [blkzone]
252,0   50       19     2.902642031   840  D ZOS N 1572864 + 0 [kworker/50:1H]
252,0   50       20     2.902655146   262  C ZOS N 1572864 + 0 [0]
252,0   52        1     2.893097612 13251  Q ZRAS N 0 + 0 [blkzone]
252,0   52        2     2.893110647 13251  G ZRAS N 0 + 0 [blkzone]
252,0   52        3     2.893114845 13251  I ZRAS N 0 + 0 [blkzone]
252,0   52        4     2.893153597  1094  D ZRAS N 0 + 0 [kworker/52:1H]
252,0   52        5     2.893185357   272  C ZRAS N 0 + 0 [0]
252,0   56        1     2.911981686 13253  Q ZCS N 0 + 0 [blkzone]
252,0   56        2     2.911988970 13253  G ZCS N 0 + 0 [blkzone]
252,0   56        3     2.911991955 13253  I ZCS N 0 + 0 [blkzone]
252,0   56        4     2.912024807   824  D ZCS N 0 + 0 [kworker/56:1H]
252,0   56        5     2.912047460   292  C ZCS N 0 + 0 [0]
252,0   56        6     2.912061145 13253  Q ZCS N 524288 + 0 [blkzone]
252,0   56        7     2.912065123 13253  G ZCS N 524288 + 0 [blkzone]
252,0   56        8     2.912067177 13253  I ZCS N 524288 + 0 [blkzone]
252,0   56        9     2.912086002   824  D ZCS N 524288 + 0 [kworker/56:1H]
252,0   56       10     2.912100780   292  C ZCS N 524288 + 0 [0]
252,0   56       11     2.912110648 13253  Q ZCS N 1048576 + 0 [blkzone]
252,0   56       12     2.912114696 13253  G ZCS N 1048576 + 0 [blkzone]
252,0   56       13     2.912116709 13253  I ZCS N 1048576 + 0 [blkzone]
252,0   56       14     2.912132148   824  D ZCS N 1048576 + 0 [kworker/56:1H]
252,0   56       15     2.912144662   292  C ZCS N 1048576 + 0 [0]
252,0   56       16     2.912153498 13253  Q ZCS N 1572864 + 0 [blkzone]
252,0   56       17     2.912157406 13253  G ZCS N 1572864 + 0 [blkzone]
252,0   56       18     2.912159389 13253  I ZCS N 1572864 + 0 [blkzone]
252,0   56       19     2.912172865   824  D ZCS N 1572864 + 0 [kworker/56:1H]
252,0   56       20     2.912185448   292  C ZCS N 1572864 + 0 [0]
252,0   15        1     2.920516322 13255  Q ZFS N 0 + 0 [blkzone]
252,0   15        2     2.920521581 13255  G ZFS N 0 + 0 [blkzone]
252,0   15        3     2.920523715 13255  I ZFS N 0 + 0 [blkzone]
252,0   15        4     2.920543833   827  D ZFS N 0 + 0 [kworker/15:1H]
252,0   15        5     2.920557739    87  C ZFS N 0 + 0 [0]
252,0   15        6     2.920565684 13255  Q ZFS N 524288 + 0 [blkzone]
252,0   15        7     2.920567938 13255  G ZFS N 524288 + 0 [blkzone]
252,0   15        8     2.920569151 13255  I ZFS N 524288 + 0 [blkzone]
252,0   15        9     2.920577967   827  D ZFS N 524288 + 0 [kworker/15:1H]
252,0   15       10     2.920585792    87  C ZFS N 524288 + 0 [0]
252,0   15       11     2.920591282 13255  Q ZFS N 1048576 + 0 [blkzone]
252,0   15       12     2.920593416 13255  G ZFS N 1048576 + 0 [blkzone]
252,0   15       13     2.920594628 13255  I ZFS N 1048576 + 0 [blkzone]
252,0   15       14     2.920631327   827  D ZFS N 1048576 + 0 [kworker/15:1H]
252,0   15       15     2.920637288    87  C ZFS N 1048576 + 0 [0]
252,0   15       16     2.920648339 13255  Q ZFS N 1572864 + 0 [blkzone]
252,0   15       17     2.920650704 13255  G ZFS N 1572864 + 0 [blkzone]
252,0   15       18     2.920651976 13255  I ZFS N 1572864 + 0 [blkzone]
252,0   15       19     2.920660181   827  D ZFS N 1572864 + 0 [kworker/15:1H]
252,0   15       20     2.920667685    87  C ZFS N 1572864 + 0 [0]
252,0   24        1     3.012679288 13265  Q ZOS I 0 + 0 [blkzone]
252,0   24        2     3.012684598 13265  G ZOS I 0 + 0 [blkzone]
252,0   24        3     3.012687714 13265  I ZOS I 0 + 0 [blkzone]
252,0   24        4     3.012714464  1030  D ZOS I 0 + 0 [kworker/24:1H]
252,0   24        5     3.012732928   132  C ZOS I 0 + 0 [0]
252,0   24        6     3.012743188 13265  Q ZOS I 524288 + 0 [blkzone]
252,0   24        7     3.012746334 13265  G ZOS I 524288 + 0 [blkzone]
252,0   24        8     3.012747997 13265  I ZOS I 524288 + 0 [blkzone]
252,0   24        9     3.012759749  1030  D ZOS I 524288 + 0 [kworker/24:1H]
252,0   24       10     3.012770228   132  C ZOS I 524288 + 0 [0]
252,0   24       11     3.012777853 13265  Q ZOS I 1048576 + 0 [blkzone]
252,0   24       12     3.012780708 13265  G ZOS I 1048576 + 0 [blkzone]
252,0   24       13     3.012782331 13265  I ZOS I 1048576 + 0 [blkzone]
252,0   24       14     3.012794023  1030  D ZOS I 1048576 + 0 [kworker/24:1H]
252,0   24       15     3.012803952   132  C ZOS I 1048576 + 0 [0]
252,0   24       16     3.012810945 13265  Q ZOS I 1572864 + 0 [blkzone]
252,0   24       17     3.012814101 13265  G ZOS I 1572864 + 0 [blkzone]
252,0   24       18     3.012815694 13265  I ZOS I 1572864 + 0 [blkzone]
252,0   24       19     3.012825873  1030  D ZOS I 1572864 + 0 [kworker/24:1H]
252,0   24       20     3.012835501   132  C ZOS I 1572864 + 0 [0]
252,0   30        1     3.004881945 13264  Q ZRAS I 0 + 0 [blkzone]
252,0   30        2     3.004889710 13264  G ZRAS I 0 + 0 [blkzone]
252,0   30        3     3.004892775 13264  I ZRAS I 0 + 0 [blkzone]
252,0   30        4     3.004923764   969  D ZRAS I 0 + 0 [kworker/30:1H]
252,0   30        5     3.004949261   162  C ZRAS I 0 + 0 [0]
252,0   33        1     3.021991231 13266  Q ZCS I 0 + 0 [blkzone]
252,0   33        2     3.021998595 13266  G ZCS I 0 + 0 [blkzone]
252,0   33        3     3.022001891 13266  I ZCS I 0 + 0 [blkzone]
252,0   33        4     3.022033901  1049  D ZCS I 0 + 0 [kworker/33:1H]
252,0   33        5     3.022056443   177  C ZCS I 0 + 0 [0]
252,0   33        6     3.022070309 13266  Q ZCS I 524288 + 0 [blkzone]
252,0   33        7     3.022074547 13266  G ZCS I 524288 + 0 [blkzone]
252,0   33        8     3.022076661 13266  I ZCS I 524288 + 0 [blkzone]
252,0   33        9     3.022092571  1049  D ZCS I 524288 + 0 [kworker/33:1H]
252,0   33       10     3.022105665   177  C ZCS I 524288 + 0 [0]
252,0   33       11     3.022115073 13266  Q ZCS I 1048576 + 0 [blkzone]
252,0   33       12     3.022118820 13266  G ZCS I 1048576 + 0 [blkzone]
252,0   33       13     3.022120894 13266  I ZCS I 1048576 + 0 [blkzone]
252,0   33       14     3.022135421  1049  D ZCS I 1048576 + 0 [kworker/33:1H]
252,0   33       15     3.022147865   177  C ZCS I 1048576 + 0 [0]
252,0   33       16     3.022156781 13266  Q ZCS I 1572864 + 0 [blkzone]
252,0   33       17     3.022160418 13266  G ZCS I 1572864 + 0 [blkzone]
252,0   33       18     3.022162412 13266  I ZCS I 1572864 + 0 [blkzone]
252,0   33       19     3.022175797  1049  D ZCS I 1572864 + 0 [kworker/33:1H]
252,0   33       20     3.022187839   177  C ZCS I 1572864 + 0 [0]
252,0   34        1     3.031471620 13267  Q ZFS I 0 + 0 [blkzone]
252,0   34        2     3.031479184 13267  G ZFS I 0 + 0 [blkzone]
252,0   34        3     3.031482169 13267  I ZFS I 0 + 0 [blkzone]
252,0   34        4     3.031522094  1050  C ZFS I 0 + 0 [0]
252,0   34        5     3.031542212 13267  Q ZFS I 524288 + 0 [blkzone]
252,0   34        6     3.031546931 13267  G ZFS I 524288 + 0 [blkzone]
252,0   34        7     3.031549085 13267  I ZFS I 524288 + 0 [blkzone]
252,0   34        8     3.031565686  1050  D ZFS I 524288 + 0 [kworker/34:1H]
252,0   34        9     3.031585894   182  C ZFS I 524288 + 0 [0]
252,0   34       10     3.031596925 13267  Q ZFS I 1048576 + 0 [blkzone]
252,0   34       11     3.031627712 13267  G ZFS I 1048576 + 0 [blkzone]
252,0   34       12     3.031630498 13267  I ZFS I 1048576 + 0 [blkzone]
252,0   34       13     3.031648161  1050  D ZFS I 1048576 + 0 [kworker/34:1H]
252,0   34       14     3.031662137   182  C ZFS I 1048576 + 0 [0]
252,0   34       15     3.031672056 13267  Q ZFS I 1572864 + 0 [blkzone]
252,0   34       16     3.031675692 13267  G ZFS I 1572864 + 0 [blkzone]
252,0   34       17     3.031677726 13267  I ZFS I 1572864 + 0 [blkzone]
252,0   34       18     3.031690831  1050  D ZFS I 1572864 + 0 [kworker/34:1H]
252,0   34       19     3.031703815   182  C ZFS I 1572864 + 0 [0]
252,0   15       21     3.031497949 13254  D ZFS I 0 + 0 [systemd-udevd]
CPU15 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU24 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU30 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU33 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU34 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        3,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU50 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU52 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU53 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU56 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          26,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       26,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       26,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 130 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xA
---------------------------------------------
252,0   36        1     2.936942216 13345  Q ZRAS R 0 + 0 [blkzone]
252,0   36        2     2.936949069 13345  G ZRAS R 0 + 0 [blkzone]
252,0   36        3     2.936952415 13345  I ZRAS R 0 + 0 [blkzone]
252,0   36        4     2.936982211   925  D ZRAS R 0 + 0 [kworker/36:1H]
252,0   36        5     2.937005966   192  C ZRAS R 0 + 0 [0]
252,0   37        1     2.946201450 13346  Q ZOS R 0 + 0 [blkzone]
252,0   37        2     2.946215006 13346  G ZOS R 0 + 0 [blkzone]
252,0   37        3     2.946219354 13346  I ZOS R 0 + 0 [blkzone]
252,0   37        4     2.946255301  1060  D ZOS R 0 + 0 [kworker/37:1H]
252,0   37        5     2.946284376   197  C ZOS R 0 + 0 [0]
252,0   37        6     2.946300636 13346  Q ZOS R 524288 + 0 [blkzone]
252,0   37        7     2.946304984 13346  G ZOS R 524288 + 0 [blkzone]
252,0   37        8     2.946307219 13346  I ZOS R 524288 + 0 [blkzone]
252,0   37        9     2.946322958  1060  D ZOS R 524288 + 0 [kworker/37:1H]
252,0   37       10     2.946336453   197  C ZOS R 524288 + 0 [0]
252,0   37       11     2.946345921 13346  Q ZOS R 1048576 + 0 [blkzone]
252,0   37       12     2.946349528 13346  G ZOS R 1048576 + 0 [blkzone]
252,0   37       13     2.946351612 13346  I ZOS R 1048576 + 0 [blkzone]
252,0   37       14     2.946365708  1060  D ZOS R 1048576 + 0 [kworker/37:1H]
252,0   37       15     2.946378462   197  C ZOS R 1048576 + 0 [0]
252,0   37       16     2.946387539 13346  Q ZOS R 1572864 + 0 [blkzone]
252,0   37       17     2.946391026 13346  G ZOS R 1572864 + 0 [blkzone]
252,0   37       18     2.946393050 13346  I ZOS R 1572864 + 0 [blkzone]
252,0   37       19     2.946405984  1060  D ZOS R 1572864 + 0 [kworker/37:1H]
252,0   37       20     2.946418447   197  C ZOS R 1572864 + 0 [0]
252,0   38        1     2.955943650 13347  Q ZCS R 0 + 0 [blkzone]
252,0   38        2     2.955952336 13347  G ZCS R 0 + 0 [blkzone]
252,0   38        3     2.955955933 13347  I ZCS R 0 + 0 [blkzone]
252,0   38        4     2.955991700  1057  D ZCS R 0 + 0 [kworker/38:1H]
252,0   38        5     2.956016797   202  C ZCS R 0 + 0 [0]
252,0   38        6     2.956031916 13347  Q ZCS R 524288 + 0 [blkzone]
252,0   38        7     2.956036174 13347  G ZCS R 524288 + 0 [blkzone]
252,0   38        8     2.956038548 13347  I ZCS R 524288 + 0 [blkzone]
252,0   38        9     2.956055800  1057  D ZCS R 524288 + 0 [kworker/38:1H]
252,0   38       10     2.956070107   202  C ZCS R 524288 + 0 [0]
252,0   38       11     2.956080567 13347  Q ZCS R 1048576 + 0 [blkzone]
252,0   38       12     2.956084705 13347  G ZCS R 1048576 + 0 [blkzone]
252,0   38       13     2.956086939 13347  I ZCS R 1048576 + 0 [blkzone]
252,0   38       14     2.956103189  1057  D ZCS R 1048576 + 0 [kworker/38:1H]
252,0   38       15     2.956116935   202  C ZCS R 1048576 + 0 [0]
252,0   38       16     2.956126914 13347  Q ZCS R 1572864 + 0 [blkzone]
252,0   38       17     2.956130831 13347  G ZCS R 1572864 + 0 [blkzone]
252,0   38       18     2.956133055 13347  I ZCS R 1572864 + 0 [blkzone]
252,0   38       19     2.956147973  1057  D ZCS R 1572864 + 0 [kworker/38:1H]
252,0   38       20     2.956161358   202  C ZCS R 1572864 + 0 [0]
252,0   24        1     2.964153807 13348  Q ZFS R 0 + 0 [blkzone]
252,0   24        2     2.964158466 13348  G ZFS R 0 + 0 [blkzone]
252,0   24        3     2.964160449 13348  I ZFS R 0 + 0 [blkzone]
252,0   24        4     2.964181669  1030  D ZFS R 0 + 0 [kworker/24:1H]
252,0   24        5     2.964196467   132  C ZFS R 0 + 0 [0]
252,0   16        1     3.010758606 13353  Q ZRAS I 0 + 0 [blkzone]
252,0   16        2     3.010766271 13353  G ZRAS I 0 + 0 [blkzone]
252,0   16        3     3.010769657 13353  I ZRAS I 0 + 0 [blkzone]
252,0   16        4     3.010804583  1728  D ZRAS I 0 + 0 [kworker/16:1H]
252,0   16        5     3.010830551    92  C ZRAS I 0 + 0 [0]
252,0   24        6     2.964249015 13348  Q ZFS R 524288 + 0 [blkzone]
252,0   24        7     2.964252071 13348  G ZFS R 524288 + 0 [blkzone]
252,0   24        8     2.964253624 13348  I ZFS R 524288 + 0 [blkzone]
252,0   24        9     2.964264024  1030  D ZFS R 524288 + 0 [kworker/24:1H]
252,0   24       10     2.964272920   132  C ZFS R 524288 + 0 [0]
252,0   24       11     2.964279302 13348  Q ZFS R 1048576 + 0 [blkzone]
252,0   24       12     2.964281827 13348  G ZFS R 1048576 + 0 [blkzone]
252,0   24       13     2.964283139 13348  I ZFS R 1048576 + 0 [blkzone]
252,0   24       14     2.964291645  1030  D ZFS R 1048576 + 0 [kworker/24:1H]
252,0   24       15     2.964299450   132  C ZFS R 1048576 + 0 [0]
252,0   24       16     2.964305692 13348  Q ZFS R 1572864 + 0 [blkzone]
252,0   24       17     2.964308257 13348  G ZFS R 1572864 + 0 [blkzone]
252,0   24       18     2.964309539 13348  I ZFS R 1572864 + 0 [blkzone]
252,0   24       19     2.964317203  1030  D ZFS R 1572864 + 0 [kworker/24:1H]
252,0   24       20     2.964324798   132  C ZFS R 1572864 + 0 [0]
252,0   16        6     3.038797028 13356  Q ZFS I 0 + 0 [blkzone]
252,0   16        7     3.038803320 13356  G ZFS I 0 + 0 [blkzone]
252,0   16        8     3.038806025 13356  I ZFS I 0 + 0 [blkzone]
252,0   16        9     3.038829308  1728  D ZFS I 0 + 0 [kworker/16:1H]
252,0   16       10     3.038845779    92  C ZFS I 0 + 0 [0]
252,0   16       11     3.038856259 13356  Q ZFS I 524288 + 0 [blkzone]
252,0   16       12     3.038859254 13356  G ZFS I 524288 + 0 [blkzone]
252,0   16       13     3.038860988 13356  I ZFS I 524288 + 0 [blkzone]
252,0   16       14     3.038874022  1728  D ZFS I 524288 + 0 [kworker/16:1H]
252,0   16       15     3.038884842    92  C ZFS I 524288 + 0 [0]
252,0   16       16     3.038892337 13356  Q ZFS I 1048576 + 0 [blkzone]
252,0   16       17     3.038895232 13356  G ZFS I 1048576 + 0 [blkzone]
252,0   16       18     3.038896835 13356  I ZFS I 1048576 + 0 [blkzone]
252,0   16       19     3.038937000  1728  D ZFS I 1048576 + 0 [kworker/16:1H]
252,0   16       20     3.038948933    92  C ZFS I 1048576 + 0 [0]
252,0   16       21     3.038956898 13356  Q ZFS I 1572864 + 0 [blkzone]
252,0   16       22     3.038960044 13356  G ZFS I 1572864 + 0 [blkzone]
252,0   16       23     3.038961727 13356  I ZFS I 1572864 + 0 [blkzone]
252,0   16       24     3.038972577  1728  D ZFS I 1572864 + 0 [kworker/16:1H]
252,0   16       25     3.038982776    92  C ZFS I 1572864 + 0 [0]
252,0   21        1     3.020425946 13354  Q ZOS I 0 + 0 [blkzone]
252,0   21        2     3.020439742 13354  G ZOS I 0 + 0 [blkzone]
252,0   21        3     3.020443759 13354  I ZOS I 0 + 0 [blkzone]
252,0   21        4     3.020480829   921  D ZOS I 0 + 0 [kworker/21:1H]
252,0   21        5     3.020508110   117  C ZOS I 0 + 0 [0]
252,0   21        6     3.020524250 13354  Q ZOS I 524288 + 0 [blkzone]
252,0   21        7     3.020528538 13354  G ZOS I 524288 + 0 [blkzone]
252,0   21        8     3.020530853 13354  I ZOS I 524288 + 0 [blkzone]
252,0   21        9     3.020547644   921  D ZOS I 524288 + 0 [kworker/21:1H]
252,0   21       10     3.020561570   117  C ZOS I 524288 + 0 [0]
252,0   21       11     3.020571339 13354  Q ZOS I 1048576 + 0 [blkzone]
252,0   21       12     3.020576899 13354  G ZOS I 1048576 + 0 [blkzone]
252,0   21       13     3.020579113 13354  I ZOS I 1048576 + 0 [blkzone]
252,0   21       14     3.020640338 13354  C ZOS I 1048576 + 0 [0]
252,0   21       15     3.020648513 13354  Q ZOS I 1572864 + 0 [blkzone]
252,0   21       16     3.020653072 13354  G ZOS I 1572864 + 0 [blkzone]
252,0   21       17     3.020655286 13354  I ZOS I 1572864 + 0 [blkzone]
252,0   21       18     3.020671587   921  D ZOS I 1572864 + 0 [kworker/21:1H]
252,0   21       19     3.020685473   117  C ZOS I 1572864 + 0 [0]
252,0    6        1     3.020587489 13343  D ZOS I 1048576 + 0 [systemd-udevd]
252,0   18        1     3.030464512 13355  Q ZCS I 0 + 0 [blkzone]
252,0   18        2     3.030470322 13355  G ZCS I 0 + 0 [blkzone]
252,0   18        3     3.030473028 13355  I ZCS I 0 + 0 [blkzone]
252,0   18        4     3.030501611  1007  D ZCS I 0 + 0 [kworker/18:1H]
252,0   18        5     3.030520827   102  C ZCS I 0 + 0 [0]
252,0   18        6     3.030531507 13355  Q ZCS I 524288 + 0 [blkzone]
252,0   18        7     3.030535174 13355  G ZCS I 524288 + 0 [blkzone]
252,0   18        8     3.030536987 13355  I ZCS I 524288 + 0 [blkzone]
252,0   18        9     3.030550272  1007  D ZCS I 524288 + 0 [kworker/18:1H]
252,0   18       10     3.030561413   102  C ZCS I 524288 + 0 [0]
252,0   18       11     3.030569398 13355  Q ZCS I 1048576 + 0 [blkzone]
252,0   18       12     3.030572424 13355  G ZCS I 1048576 + 0 [blkzone]
252,0   18       13     3.030574187 13355  I ZCS I 1048576 + 0 [blkzone]
252,0   18       14     3.030586631  1007  D ZCS I 1048576 + 0 [kworker/18:1H]
252,0   18       15     3.030597431   102  C ZCS I 1048576 + 0 [0]
252,0   18       16     3.030605015 13355  Q ZCS I 1572864 + 0 [blkzone]
252,0   18       17     3.030608071 13355  G ZCS I 1572864 + 0 [blkzone]
252,0   18       18     3.030609754 13355  I ZCS I 1572864 + 0 [blkzone]
252,0   18       19     3.030621235  1007  D ZCS I 1572864 + 0 [kworker/18:1H]
252,0   18       20     3.030631625   102  C ZCS I 1572864 + 0 [0]
CPU6 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU16 (252,0):
 Reads Queued:           5,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU18 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        3,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU24 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU36 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU37 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU38 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             2        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          26,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       26,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       26,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 130 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xB
---------------------------------------------
252,0   15        1     2.900754341 13430  Q ZRAS N 0 + 0 [blkzone]
252,0   15        2     2.900764009 13430  G ZRAS N 0 + 0 [blkzone]
252,0   15        3     2.900767636 13430  I ZRAS N 0 + 0 [blkzone]
252,0   15        4     2.900800047   827  D ZRAS N 0 + 0 [kworker/15:1H]
252,0   15        5     2.900827298    87  C ZRAS N 0 + 0 [0]
252,0   18        1     2.912047409 13431  Q ZOS N 0 + 0 [blkzone]
252,0   18        2     2.912054413 13431  G ZOS N 0 + 0 [blkzone]
252,0   18        3     2.912057879 13431  I ZOS N 0 + 0 [blkzone]
252,0   18        4     2.912090831  1007  D ZOS N 0 + 0 [kworker/18:1H]
252,0   18        5     2.912119114   102  C ZOS N 0 + 0 [0]
252,0   15        6     2.957739327 13437  Q ZCS R 0 + 0 [blkzone]
252,0   15        7     2.957748093 13437  G ZCS R 0 + 0 [blkzone]
252,0   15        8     2.957751730 13437  I ZCS R 0 + 0 [blkzone]
252,0   15        9     2.957781586   827  D ZCS R 0 + 0 [kworker/15:1H]
252,0   15       10     2.957802025    87  C ZCS R 0 + 0 [0]
252,0   15       11     2.957815530 13437  Q ZCS R 524288 + 0 [blkzone]
252,0   15       12     2.957819618 13437  G ZCS R 524288 + 0 [blkzone]
252,0   15       13     2.957821752 13437  I ZCS R 524288 + 0 [blkzone]
252,0   15       14     2.957838012   827  D ZCS R 524288 + 0 [kworker/15:1H]
252,0   15       15     2.957851067    87  C ZCS R 524288 + 0 [0]
252,0   15       16     2.957860524 13437  Q ZCS R 1048576 + 0 [blkzone]
252,0   15       17     2.957864482 13437  G ZCS R 1048576 + 0 [blkzone]
252,0   15       18     2.957866526 13437  I ZCS R 1048576 + 0 [blkzone]
252,0   15       19     2.957881604   827  D ZCS R 1048576 + 0 [kworker/15:1H]
252,0   15       20     2.957893967    87  C ZCS R 1048576 + 0 [0]
252,0   15       21     2.957902804 13437  Q ZCS R 1572864 + 0 [blkzone]
252,0   15       22     2.957906310 13437  G ZCS R 1572864 + 0 [blkzone]
252,0   15       23     2.957908314 13437  I ZCS R 1572864 + 0 [blkzone]
252,0   15       24     2.957921909   827  D ZCS R 1572864 + 0 [kworker/15:1H]
252,0   15       25     2.957934002    87  C ZCS R 1572864 + 0 [0]
252,0   20        1     2.922566206 13432  Q ZCS N 0 + 0 [blkzone]
252,0   20        2     2.922578689 13432  G ZCS N 0 + 0 [blkzone]
252,0   20        3     2.922582737 13432  I ZCS N 0 + 0 [blkzone]
252,0   20        4     2.922616740 13432  Q ZCS N 524288 + 0 [blkzone]
252,0   20        5     2.922621690 13432  G ZCS N 524288 + 0 [blkzone]
252,0   20        6     2.922624235 13432  I ZCS N 524288 + 0 [blkzone]
252,0   20        7     2.922644322 13432  Q ZCS N 1048576 + 0 [blkzone]
252,0   20        8     2.922649061 13432  G ZCS N 1048576 + 0 [blkzone]
252,0   20        9     2.922651035 13432  I ZCS N 1048576 + 0 [blkzone]
252,0   20       10     2.922658509 13432  Q ZCS N 1572864 + 0 [blkzone]
252,0   20       11     2.922662657 13432  G ZCS N 1572864 + 0 [blkzone]
252,0   20       12     2.922664841 13432  I ZCS N 1572864 + 0 [blkzone]
252,0   20       13     2.922815313     0  C ZCS N 0 + 0 [0]
252,0   20       14     2.922825302     0  C ZCS N 524288 + 0 [0]
252,0   20       15     2.922829349     0  C ZCS N 1048576 + 0 [0]
252,0   20       16     2.922832876     0  C ZCS N 1572864 + 0 [0]
252,0   18        6     2.912205185 13431  Q ZOS N 524288 + 0 [blkzone]
252,0   18        7     2.912210295 13431  G ZOS N 524288 + 0 [blkzone]
252,0   18        8     2.912213110 13431  I ZOS N 524288 + 0 [blkzone]
252,0   18        9     2.912233018  1007  D ZOS N 524288 + 0 [kworker/18:1H]
252,0   18       10     2.912249849   102  C ZOS N 524288 + 0 [0]
252,0   18       11     2.912281579 13431  Q ZOS N 1048576 + 0 [blkzone]
252,0   18       12     2.912286358 13431  G ZOS N 1048576 + 0 [blkzone]
252,0   18       13     2.912289253 13431  I ZOS N 1048576 + 0 [blkzone]
252,0   18       14     2.912307678  1007  D ZOS N 1048576 + 0 [kworker/18:1H]
252,0   18       15     2.912323377   102  C ZOS N 1048576 + 0 [0]
252,0   18       16     2.912334408 13431  Q ZOS N 1572864 + 0 [blkzone]
252,0   18       17     2.912338876 13431  G ZOS N 1572864 + 0 [blkzone]
252,0   18       18     2.912341511 13431  I ZOS N 1572864 + 0 [blkzone]
252,0   18       19     2.912357621  1007  D ZOS N 1572864 + 0 [kworker/18:1H]
252,0   18       20     2.912372379   102  C ZOS N 1572864 + 0 [0]
252,0   25        1     2.929832793 13434  Q ZFS N 0 + 0 [blkzone]
252,0   25        2     2.929839015 13434  G ZFS N 0 + 0 [blkzone]
252,0   25        3     2.929841429 13434  I ZFS N 0 + 0 [blkzone]
252,0   25        4     2.929870684  1053  D ZFS N 0 + 0 [kworker/25:1H]
252,0   25        5     2.929891854   137  C ZFS N 0 + 0 [0]
252,0   25        6     2.929902043 13434  Q ZFS N 524288 + 0 [blkzone]
252,0   25        7     2.929905469 13434  G ZFS N 524288 + 0 [blkzone]
252,0   25        8     2.929907183 13434  I ZFS N 524288 + 0 [blkzone]
252,0   25        9     2.929919075  1053  D ZFS N 524288 + 0 [kworker/25:1H]
252,0   25       10     2.929929524   137  C ZFS N 524288 + 0 [0]
252,0   25       11     2.929936878 13434  Q ZFS N 1048576 + 0 [blkzone]
252,0   25       12     2.929939774 13434  G ZFS N 1048576 + 0 [blkzone]
252,0   25       13     2.929941377 13434  I ZFS N 1048576 + 0 [blkzone]
252,0   25       14     2.929952538  1053  D ZFS N 1048576 + 0 [kworker/25:1H]
252,0   25       15     2.929962657   137  C ZFS N 1048576 + 0 [0]
252,0   25       16     2.929969720 13434  Q ZFS N 1572864 + 0 [blkzone]
252,0   25       17     2.929972475 13434  G ZFS N 1572864 + 0 [blkzone]
252,0   25       18     2.929973998 13434  I ZFS N 1572864 + 0 [blkzone]
252,0   25       19     2.930009314  1053  D ZFS N 1572864 + 0 [kworker/25:1H]
252,0   25       20     2.930020285   137  C ZFS N 1572864 + 0 [0]
252,0   28        1     2.948481816 13436  Q ZOS R 0 + 0 [blkzone]
252,0   28        2     2.948489370 13436  G ZOS R 0 + 0 [blkzone]
252,0   28        3     2.948492927 13436  I ZOS R 0 + 0 [blkzone]
252,0   28        4     2.948528864  1041  D ZOS R 0 + 0 [kworker/28:1H]
252,0   28        5     2.948552078   152  C ZOS R 0 + 0 [0]
252,0   28        6     2.948565493 13436  Q ZOS R 524288 + 0 [blkzone]
252,0   28        7     2.948569551 13436  G ZOS R 524288 + 0 [blkzone]
252,0   28        8     2.948571785 13436  I ZOS R 524288 + 0 [blkzone]
252,0   28        9     2.948586703  1041  D ZOS R 524288 + 0 [kworker/28:1H]
252,0   28       10     2.948600529   152  C ZOS R 524288 + 0 [0]
252,0   28       11     2.948610037 13436  Q ZOS R 1048576 + 0 [blkzone]
252,0   28       12     2.948613954 13436  G ZOS R 1048576 + 0 [blkzone]
252,0   28       13     2.948615958 13436  I ZOS R 1048576 + 0 [blkzone]
252,0   28       14     2.948630084  1041  D ZOS R 1048576 + 0 [kworker/28:1H]
252,0   28       15     2.948642888   152  C ZOS R 1048576 + 0 [0]
252,0   28       16     2.948651895 13436  Q ZOS R 1572864 + 0 [blkzone]
252,0   28       17     2.948655502 13436  G ZOS R 1572864 + 0 [blkzone]
252,0   28       18     2.948657506 13436  I ZOS R 1572864 + 0 [blkzone]
252,0   28       19     2.948670109  1041  D ZOS R 1572864 + 0 [kworker/28:1H]
252,0   28       20     2.948682593   152  C ZOS R 1572864 + 0 [0]
252,0   23        1     2.922664410  1062  D ZCS N 0 + 0 [kworker/23:1H]
252,0   23        2     2.922675851  1062  D ZCS N 524288 + 0 [kworker/23:1H]
252,0   23        3     2.922679538  1062  D ZCS N 1048576 + 0 [kworker/23:1H]
252,0   23        4     2.922686141  1062  D ZCS N 1572864 + 0 [kworker/23:1H]
252,0   27        1     2.939232931 13435  Q ZRAS R 0 + 0 [blkzone]
252,0   27        2     2.939243682 13435  G ZRAS R 0 + 0 [blkzone]
252,0   27        3     2.939247399 13435  I ZRAS R 0 + 0 [blkzone]
252,0   27        4     2.939306479   815  D ZRAS R 0 + 0 [kworker/27:1H]
252,0   27        5     2.939332789   147  C ZRAS R 0 + 0 [0]
252,0   23        5     2.968012873 13433  D ZFS R 0 + 0 [systemd-udevd]
252,0   23        6     2.968080059 13433  D ZFS R 524288 + 0 [systemd-udevd]
252,0   23        7     2.968133960 13433  D ZFS R 1048576 + 0 [systemd-udevd]
252,0   21        1     3.014855930 13443  Q ZRAS I 0 + 0 [blkzone]
252,0   21        2     3.014863604 13443  G ZRAS I 0 + 0 [blkzone]
252,0   21        3     3.014866680 13443  I ZRAS I 0 + 0 [blkzone]
252,0   21        4     3.014917796   921  D ZRAS I 0 + 0 [kworker/21:1H]
252,0   21        5     3.014942712   117  C ZRAS I 0 + 0 [0]
252,0   26        1     2.967985091 13438  Q ZFS R 0 + 0 [blkzone]
252,0   26        2     2.967993607 13438  G ZFS R 0 + 0 [blkzone]
252,0   26        3     2.967999629 13438  I ZFS R 0 + 0 [blkzone]
252,0   26        4     2.968043741   830  C ZFS R 0 + 0 [0]
252,0   26        5     2.968066284 13438  Q ZFS R 524288 + 0 [blkzone]
252,0   26        6     2.968072696 13438  G ZFS R 524288 + 0 [blkzone]
252,0   26        7     2.968075381 13438  I ZFS R 524288 + 0 [blkzone]
252,0   26        8     2.968097923   830  C ZFS R 524288 + 0 [0]
252,0   26        9     2.968114093 13438  Q ZFS R 1048576 + 0 [blkzone]
252,0   26       10     2.968118812 13438  G ZFS R 1048576 + 0 [blkzone]
252,0   26       11     2.968121086 13438  I ZFS R 1048576 + 0 [blkzone]
252,0   26       12     2.968149069 13438  C ZFS R 1048576 + 0 [0]
252,0   26       13     2.968156433 13438  Q ZFS R 1572864 + 0 [blkzone]
252,0   26       14     2.968160711 13438  G ZFS R 1572864 + 0 [blkzone]
252,0   26       15     2.968162845 13438  I ZFS R 1572864 + 0 [blkzone]
252,0   26       16     2.968179466   830  D ZFS R 1572864 + 0 [kworker/26:1H]
252,0   26       17     2.968215093   142  C ZFS R 1572864 + 0 [0]
252,0   35        1     3.023830049 13444  Q ZOS I 0 + 0 [blkzone]
252,0   35        2     3.023838064 13444  G ZOS I 0 + 0 [blkzone]
252,0   35        3     3.023840729 13444  I ZOS I 0 + 0 [blkzone]
252,0   35        4     3.023870194  1055  D ZOS I 0 + 0 [kworker/35:1H]
252,0   35        5     3.023890392   187  C ZOS I 0 + 0 [0]
252,0   35        6     3.023901694 13444  Q ZOS I 524288 + 0 [blkzone]
252,0   35        7     3.023904960 13444  G ZOS I 524288 + 0 [blkzone]
252,0   35        8     3.023906603 13444  I ZOS I 524288 + 0 [blkzone]
252,0   35        9     3.023918595  1055  D ZOS I 524288 + 0 [kworker/35:1H]
252,0   35       10     3.023929005   187  C ZOS I 524288 + 0 [0]
252,0   35       11     3.023936459 13444  Q ZOS I 1048576 + 0 [blkzone]
252,0   35       12     3.023939484 13444  G ZOS I 1048576 + 0 [blkzone]
252,0   35       13     3.023941178 13444  I ZOS I 1048576 + 0 [blkzone]
252,0   35       14     3.023952148  1055  D ZOS I 1048576 + 0 [kworker/35:1H]
252,0   35       15     3.023961866   187  C ZOS I 1048576 + 0 [0]
252,0   35       16     3.023968890 13444  Q ZOS I 1572864 + 0 [blkzone]
252,0   35       17     3.023971645 13444  G ZOS I 1572864 + 0 [blkzone]
252,0   35       18     3.023973188 13444  I ZOS I 1572864 + 0 [blkzone]
252,0   35       19     3.023983347  1055  D ZOS I 1572864 + 0 [kworker/35:1H]
252,0   35       20     3.023993155   187  C ZOS I 1572864 + 0 [0]
252,0   37        1     3.032730280 13445  Q ZCS I 0 + 0 [blkzone]
252,0   37        2     3.032739016 13445  G ZCS I 0 + 0 [blkzone]
252,0   37        3     3.032742273 13445  I ZCS I 0 + 0 [blkzone]
252,0   37        4     3.032775264  1060  D ZCS I 0 + 0 [kworker/37:1H]
252,0   37        5     3.032797526   197  C ZCS I 0 + 0 [0]
252,0   37        6     3.032811362 13445  Q ZCS I 524288 + 0 [blkzone]
252,0   37        7     3.032815570 13445  G ZCS I 524288 + 0 [blkzone]
252,0   37        8     3.032817784 13445  I ZCS I 524288 + 0 [blkzone]
252,0   37        9     3.032834085  1060  D ZCS I 524288 + 0 [kworker/37:1H]
252,0   37       10     3.032847149   197  C ZCS I 524288 + 0 [0]
252,0   37       11     3.032856597 13445  Q ZCS I 1048576 + 0 [blkzone]
252,0   37       12     3.032860364 13445  G ZCS I 1048576 + 0 [blkzone]
252,0   37       13     3.032862358 13445  I ZCS I 1048576 + 0 [blkzone]
252,0   37       14     3.032877396  1060  D ZCS I 1048576 + 0 [kworker/37:1H]
252,0   37       15     3.032889939   197  C ZCS I 1048576 + 0 [0]
252,0   37       16     3.032898956 13445  Q ZCS I 1572864 + 0 [blkzone]
252,0   37       17     3.032902603 13445  G ZCS I 1572864 + 0 [blkzone]
252,0   37       18     3.032904587 13445  I ZCS I 1572864 + 0 [blkzone]
252,0   37       19     3.032918062  1060  D ZCS I 1572864 + 0 [kworker/37:1H]
252,0   37       20     3.032930275   197  C ZCS I 1572864 + 0 [0]
252,0   46        1     3.041914644 13446  Q ZFS I 0 + 0 [blkzone]
252,0   46        2     3.041921186 13446  G ZFS I 0 + 0 [blkzone]
252,0   46        3     3.041924302 13446  I ZFS I 0 + 0 [blkzone]
252,0   46        4     3.041954979   835  D ZFS I 0 + 0 [kworker/46:1H]
252,0   46        5     3.041976790   242  C ZFS I 0 + 0 [0]
252,0   46        6     3.042020783 13446  Q ZFS I 524288 + 0 [blkzone]
252,0   46        7     3.042025031 13446  G ZFS I 524288 + 0 [blkzone]
252,0   46        8     3.042027425 13446  I ZFS I 524288 + 0 [blkzone]
252,0   46        9     3.042044517   835  D ZFS I 524288 + 0 [kworker/46:1H]
252,0   46       10     3.042058664   242  C ZFS I 524288 + 0 [0]
252,0   46       11     3.042068472 13446  Q ZFS I 1048576 + 0 [blkzone]
252,0   46       12     3.042072029 13446  G ZFS I 1048576 + 0 [blkzone]
252,0   46       13     3.042074133 13446  I ZFS I 1048576 + 0 [blkzone]
252,0   46       14     3.042088520   835  D ZFS I 1048576 + 0 [kworker/46:1H]
252,0   46       15     3.042101314   242  C ZFS I 1048576 + 0 [0]
252,0   46       16     3.042110671 13446  Q ZFS I 1572864 + 0 [blkzone]
252,0   46       17     3.042114258 13446  G ZFS I 1572864 + 0 [blkzone]
252,0   46       18     3.042116362 13446  I ZFS I 1572864 + 0 [blkzone]
252,0   46       19     3.042129296   835  D ZFS I 1572864 + 0 [kworker/46:1H]
252,0   46       20     3.042141940   242  C ZFS I 1572864 + 0 [0]
CPU15 (252,0):
 Reads Queued:           5,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        5,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        5,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU18 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU20 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU21 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU23 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        7,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU25 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU26 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU27 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU28 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU35 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU37 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU46 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             8        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          39,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       39,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       39,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 195 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xC
---------------------------------------------
252,0   36        1     3.004977474 13539  Q ZRAS I 0 + 0 [blkzone]
252,0   36        2     3.004991511 13539  G ZRAS I 0 + 0 [blkzone]
252,0   36        3     3.004995749 13539  I ZRAS I 0 + 0 [blkzone]
252,0   36        4     3.005036996   925  D ZRAS I 0 + 0 [kworker/36:1H]
252,0   36        5     3.005066661   192  C ZRAS I 0 + 0 [0]
252,0   18        1     2.995407307 13538  Q ZFS B 0 + 0 [blkzone]
252,0   18        2     2.995412587 13538  G ZFS B 0 + 0 [blkzone]
252,0   18        3     2.995414480 13538  I ZFS B 0 + 0 [blkzone]
252,0   18        4     2.995434538  1007  D ZFS B 0 + 0 [kworker/18:1H]
252,0   18        5     2.995448755   102  C ZFS B 0 + 0 [0]
252,0   18        6     2.995457221 13538  Q ZFS B 524288 + 0 [blkzone]
252,0   18        7     2.995460026 13538  G ZFS B 524288 + 0 [blkzone]
252,0   18        8     2.995461368 13538  I ZFS B 524288 + 0 [blkzone]
252,0   18        9     2.995470576  1007  D ZFS B 524288 + 0 [kworker/18:1H]
252,0   18       10     2.995478601   102  C ZFS B 524288 + 0 [0]
252,0   18       11     2.995484432 13538  Q ZFS B 1048576 + 0 [blkzone]
252,0   18       12     2.995486746 13538  G ZFS B 1048576 + 0 [blkzone]
252,0   18       13     2.995488048 13538  I ZFS B 1048576 + 0 [blkzone]
252,0   18       14     2.995496454  1007  D ZFS B 1048576 + 0 [kworker/18:1H]
252,0   18       15     2.995504149   102  C ZFS B 1048576 + 0 [0]
252,0   18       16     2.995509729 13538  Q ZFS B 1572864 + 0 [blkzone]
252,0   18       17     2.995511953 13538  G ZFS B 1572864 + 0 [blkzone]
252,0   18       18     2.995513216 13538  I ZFS B 1572864 + 0 [blkzone]
252,0   18       19     2.995521020  1007  D ZFS B 1572864 + 0 [kworker/18:1H]
252,0   18       20     2.995528574   102  C ZFS B 1572864 + 0 [0]
252,0   16        1     2.969638061 13535  Q ZRAS B 0 + 0 [blkzone]
252,0   16        2     2.969645866 13535  G ZRAS B 0 + 0 [blkzone]
252,0   16        3     2.969649052 13535  I ZRAS B 0 + 0 [blkzone]
252,0   16        4     2.969680380  1728  D ZRAS B 0 + 0 [kworker/16:1H]
252,0   16        5     2.969703333    92  C ZRAS B 0 + 0 [0]
252,0   23        1     3.014320105 13540  Q ZOS I 0 + 0 [blkzone]
252,0   23        2     3.014326377 13540  G ZOS I 0 + 0 [blkzone]
252,0   23        3     3.014328981 13540  I ZOS I 0 + 0 [blkzone]
252,0   23        4     3.014361022  1062  C ZOS I 0 + 0 [0]
252,0   61        1     2.978608964 13536  Q ZOS B 0 + 0 [blkzone]
252,0   61        2     2.978616318 13536  G ZOS B 0 + 0 [blkzone]
252,0   61        3     2.978619354 13536  I ZOS B 0 + 0 [blkzone]
252,0   61        4     2.978649801  1027  D ZOS B 0 + 0 [kworker/61:1H]
252,0   61        5     2.978671331   317  C ZOS B 0 + 0 [0]
252,0   61        6     2.978684035 13536  Q ZOS B 524288 + 0 [blkzone]
252,0   61        7     2.978688053 13536  G ZOS B 524288 + 0 [blkzone]
252,0   61        8     2.978690257 13536  I ZOS B 524288 + 0 [blkzone]
252,0   61        9     2.978705335  1027  D ZOS B 524288 + 0 [kworker/61:1H]
252,0   61       10     2.978718660   317  C ZOS B 524288 + 0 [0]
252,0   61       11     2.978728018 13536  Q ZOS B 1048576 + 0 [blkzone]
252,0   61       12     2.978731574 13536  G ZOS B 1048576 + 0 [blkzone]
252,0   61       13     2.978733608 13536  I ZOS B 1048576 + 0 [blkzone]
252,0   61       14     2.978747544  1027  D ZOS B 1048576 + 0 [kworker/61:1H]
252,0   61       15     2.978760178   317  C ZOS B 1048576 + 0 [0]
252,0   61       16     2.978769155 13536  Q ZOS B 1572864 + 0 [blkzone]
252,0   61       17     2.978772611 13536  G ZOS B 1572864 + 0 [blkzone]
252,0   61       18     2.978774605 13536  I ZOS B 1572864 + 0 [blkzone]
252,0   61       19     2.978787449  1027  D ZOS B 1572864 + 0 [kworker/61:1H]
252,0   61       20     2.978799893   317  C ZOS B 1572864 + 0 [0]
252,0    7        1     2.988714315 13537  Q ZCS B 0 + 0 [blkzone]
252,0    7        2     2.988721839 13537  G ZCS B 0 + 0 [blkzone]
252,0    7        3     2.988725356 13537  I ZCS B 0 + 0 [blkzone]
252,0    7        4     2.988761554   828  D ZCS B 0 + 0 [kworker/7:1H]
252,0    7        5     2.988786000    47  C ZCS B 0 + 0 [0]
252,0    7        6     2.988802240 13537  Q ZCS B 524288 + 0 [blkzone]
252,0    7        7     2.988806829 13537  G ZCS B 524288 + 0 [blkzone]
252,0    7        8     2.988809484 13537  I ZCS B 524288 + 0 [blkzone]
252,0    7        9     2.988828209   828  D ZCS B 524288 + 0 [kworker/7:1H]
252,0    7       10     2.988844089    47  C ZCS B 524288 + 0 [0]
252,0    7       11     2.988855450 13537  Q ZCS B 1048576 + 0 [blkzone]
252,0    7       12     2.988859908 13537  G ZCS B 1048576 + 0 [blkzone]
252,0    7       13     2.988862393 13537  I ZCS B 1048576 + 0 [blkzone]
252,0    7       14     2.988879926   828  D ZCS B 1048576 + 0 [kworker/7:1H]
252,0    7       15     2.988895134    47  C ZCS B 1048576 + 0 [0]
252,0    7       16     2.988905925 13537  Q ZCS B 1572864 + 0 [blkzone]
252,0    7       17     2.988910333 13537  G ZCS B 1572864 + 0 [blkzone]
252,0    7       18     2.988912768 13537  I ZCS B 1572864 + 0 [blkzone]
252,0    7       19     2.988929048   828  D ZCS B 1572864 + 0 [kworker/7:1H]
252,0    7       20     2.988943936    47  C ZCS B 1572864 + 0 [0]
252,0   28        1     3.014340363 13529  D ZOS I 0 + 0 [systemd-udevd]
252,0   28        2     3.014453275 13529  D ZOS I 524288 + 0 [systemd-udevd]
252,0   39        1     3.034083438 13542  Q ZFS I 0 + 0 [blkzone]
252,0   39        2     3.034093426 13542  G ZFS I 0 + 0 [blkzone]
252,0   39        3     3.034097123 13542  I ZFS I 0 + 0 [blkzone]
252,0   39        4     3.034133702   533  D ZFS I 0 + 0 [kworker/39:1H]
252,0   39        5     3.034159861   207  C ZFS I 0 + 0 [0]
252,0   39        6     3.034174629 13542  Q ZFS I 524288 + 0 [blkzone]
252,0   39        7     3.034179087 13542  G ZFS I 524288 + 0 [blkzone]
252,0   39        8     3.034181461 13542  I ZFS I 524288 + 0 [blkzone]
252,0   39        9     3.034197832   533  D ZFS I 524288 + 0 [kworker/39:1H]
252,0   39       10     3.034212299   207  C ZFS I 524288 + 0 [0]
252,0   39       11     3.034223190 13542  Q ZFS I 1048576 + 0 [blkzone]
252,0   39       12     3.034227267 13542  G ZFS I 1048576 + 0 [blkzone]
252,0   39       13     3.034229552 13542  I ZFS I 1048576 + 0 [blkzone]
252,0   39       14     3.034245131   533  D ZFS I 1048576 + 0 [kworker/39:1H]
252,0   39       15     3.034301366   207  C ZFS I 1048576 + 0 [0]
252,0   39       16     3.034316214 13542  Q ZFS I 1572864 + 0 [blkzone]
252,0   39       17     3.034320913 13542  G ZFS I 1572864 + 0 [blkzone]
252,0   39       18     3.034323488 13542  I ZFS I 1572864 + 0 [blkzone]
252,0   39       19     3.034341021   533  D ZFS I 1572864 + 0 [kworker/39:1H]
252,0   39       20     3.034359135   207  C ZFS I 1572864 + 0 [0]
252,0   23        5     3.014432295 13540  Q ZOS I 524288 + 0 [blkzone]
252,0   23        6     3.014436924 13540  G ZOS I 524288 + 0 [blkzone]
252,0   23        7     3.014439078 13540  I ZOS I 524288 + 0 [blkzone]
252,0   23        8     3.014458043 13540  Q ZOS I 1048576 + 0 [blkzone]
252,0   23        9     3.014466489 13540  C ZOS I 524288 + 0 [0]
252,0   23       10     3.014474655 13540  G ZOS I 1048576 + 0 [blkzone]
252,0   23       11     3.014476448 13540  I ZOS I 1048576 + 0 [blkzone]
252,0   23       12     3.014491707  1062  D ZOS I 1048576 + 0 [kworker/23:1H]
252,0   23       13     3.014508448   127  C ZOS I 1048576 + 0 [0]
252,0   23       14     3.014517174 13540  Q ZOS I 1572864 + 0 [blkzone]
252,0   23       15     3.014520380 13540  G ZOS I 1572864 + 0 [blkzone]
252,0   23       16     3.014522144 13540  I ZOS I 1572864 + 0 [blkzone]
252,0   23       17     3.014537943  1062  D ZOS I 1572864 + 0 [kworker/23:1H]
252,0   23       18     3.014551128   127  C ZOS I 1572864 + 0 [0]
252,0   30        1     3.023950856 13541  Q ZCS I 0 + 0 [blkzone]
252,0   30        2     3.023958580 13541  G ZCS I 0 + 0 [blkzone]
252,0   30        3     3.023961676 13541  I ZCS I 0 + 0 [blkzone]
252,0   30        4     3.023995049   969  D ZCS I 0 + 0 [kworker/30:1H]
252,0   30        5     3.024018402   162  C ZCS I 0 + 0 [0]
252,0   30        6     3.024031878 13541  Q ZCS I 524288 + 0 [blkzone]
252,0   30        7     3.024036116 13541  G ZCS I 524288 + 0 [blkzone]
252,0   30        8     3.024038260 13541  I ZCS I 524288 + 0 [blkzone]
252,0   30        9     3.024054460   969  D ZCS I 524288 + 0 [kworker/30:1H]
252,0   30       10     3.024067675   162  C ZCS I 524288 + 0 [0]
252,0   30       11     3.024077233 13541  Q ZCS I 1048576 + 0 [blkzone]
252,0   30       12     3.024081220 13541  G ZCS I 1048576 + 0 [blkzone]
252,0   30       13     3.024083234 13541  I ZCS I 1048576 + 0 [blkzone]
252,0   30       14     3.024098282   969  D ZCS I 1048576 + 0 [kworker/30:1H]
252,0   30       15     3.024111036   162  C ZCS I 1048576 + 0 [0]
252,0   30       16     3.024120083 13541  Q ZCS I 1572864 + 0 [blkzone]
252,0   30       17     3.024123690 13541  G ZCS I 1572864 + 0 [blkzone]
252,0   30       18     3.024125754 13541  I ZCS I 1572864 + 0 [blkzone]
252,0   30       19     3.024139369   969  D ZCS I 1572864 + 0 [kworker/30:1H]
252,0   30       20     3.024151672   162  C ZCS I 1572864 + 0 [0]
CPU7 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU16 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU18 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU20 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU23 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        2,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU28 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        2,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU30 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU36 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU39 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU61 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          26,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       26,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       26,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 130 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xD
---------------------------------------------
252,0    2        1     2.901862189 13615  Q ZRAS N 0 + 0 [blkzone]
252,0    2        2     2.901871496 13615  G ZRAS N 0 + 0 [blkzone]
252,0    2        3     2.901875123 13615  I ZRAS N 0 + 0 [blkzone]
252,0    2        4     2.901907835  1449  D ZRAS N 0 + 0 [kworker/2:1H]
252,0    2        5     2.901931339    22  C ZRAS N 0 + 0 [0]
252,0    5        1     2.911536051 13616  Q ZOS N 0 + 0 [blkzone]
252,0    5        2     2.911542322 13616  G ZOS N 0 + 0 [blkzone]
252,0    5        3     2.911545538 13616  I ZOS N 0 + 0 [blkzone]
252,0    5        4     2.911576527  1507  D ZOS N 0 + 0 [kworker/5:1H]
252,0    5        5     2.911599550    37  C ZOS N 0 + 0 [0]
252,0    5        6     2.911612644 13616  Q ZOS N 524288 + 0 [blkzone]
252,0    5        7     2.911616562 13616  G ZOS N 524288 + 0 [blkzone]
252,0    5        8     2.911618616 13616  I ZOS N 524288 + 0 [blkzone]
252,0    5        9     2.911633564  1507  D ZOS N 524288 + 0 [kworker/5:1H]
252,0    5       10     2.911647079    37  C ZOS N 524288 + 0 [0]
252,0    5       11     2.911656497 13616  Q ZOS N 1048576 + 0 [blkzone]
252,0    5       12     2.911660113 13616  G ZOS N 1048576 + 0 [blkzone]
252,0    5       13     2.911662147 13616  I ZOS N 1048576 + 0 [blkzone]
252,0    5       14     2.911676594  1507  D ZOS N 1048576 + 0 [kworker/5:1H]
252,0    5       15     2.911689258    37  C ZOS N 1048576 + 0 [0]
252,0    5       16     2.911698395 13616  Q ZOS N 1572864 + 0 [blkzone]
252,0    5       17     2.911702052 13616  G ZOS N 1572864 + 0 [blkzone]
252,0    5       18     2.911704106 13616  I ZOS N 1572864 + 0 [blkzone]
252,0    5       19     2.911716730  1507  D ZOS N 1572864 + 0 [kworker/5:1H]
252,0    5       20     2.911730656    37  C ZOS N 1572864 + 0 [0]
252,0    4        1     2.930203739 13619  Q ZFS N 0 + 0 [blkzone]
252,0    4        2     2.930210221 13619  G ZFS N 0 + 0 [blkzone]
252,0    4        3     2.930212455 13619  I ZFS N 0 + 0 [blkzone]
252,0    4        4     2.930238885   968  D ZFS N 0 + 0 [kworker/4:1H]
252,0    4        5     2.930257780    32  C ZFS N 0 + 0 [0]
252,0    4        6     2.930267689 13619  Q ZFS N 524288 + 0 [blkzone]
252,0    4        7     2.930270053 13619  G ZFS N 524288 + 0 [blkzone]
252,0    4        8     2.930271316 13619  I ZFS N 524288 + 0 [blkzone]
252,0    4        9     2.930280262   968  D ZFS N 524288 + 0 [kworker/4:1H]
252,0    4       10     2.930288267    32  C ZFS N 524288 + 0 [0]
252,0    4       11     2.930293898 13619  Q ZFS N 1048576 + 0 [blkzone]
252,0    4       12     2.930296032 13619  G ZFS N 1048576 + 0 [blkzone]
252,0    4       13     2.930297254 13619  I ZFS N 1048576 + 0 [blkzone]
252,0    4       14     2.930305349   968  D ZFS N 1048576 + 0 [kworker/4:1H]
252,0    4       15     2.930312843    32  C ZFS N 1048576 + 0 [0]
252,0    4       16     2.930318324 13619  Q ZFS N 1572864 + 0 [blkzone]
252,0    4       17     2.930320378 13619  G ZFS N 1572864 + 0 [blkzone]
252,0    4       18     2.930321570 13619  I ZFS N 1572864 + 0 [blkzone]
252,0    4       19     2.930329044   968  D ZFS N 1572864 + 0 [kworker/4:1H]
252,0    4       20     2.930336678    32  C ZFS N 1572864 + 0 [0]
252,0   40        1     2.922041953 13618  Q ZCS N 0 + 0 [blkzone]
252,0   40        2     2.922049457 13618  G ZCS N 0 + 0 [blkzone]
252,0   40        3     2.922052873 13618  I ZCS N 0 + 0 [blkzone]
252,0   40        4     2.922088560  1058  D ZCS N 0 + 0 [kworker/40:1H]
252,0   40        5     2.922112746   212  C ZCS N 0 + 0 [0]
252,0   40        6     2.922126692 13618  Q ZCS N 524288 + 0 [blkzone]
252,0   40        7     2.922131010 13618  G ZCS N 524288 + 0 [blkzone]
252,0   40        8     2.922133384 13618  I ZCS N 524288 + 0 [blkzone]
252,0   40        9     2.922151077  1058  D ZCS N 524288 + 0 [kworker/40:1H]
252,0   40       10     2.922165755   212  C ZCS N 524288 + 0 [0]
252,0   40       11     2.922176054 13618  Q ZCS N 1048576 + 0 [blkzone]
252,0   40       12     2.922180162 13618  G ZCS N 1048576 + 0 [blkzone]
252,0   40       13     2.922182466 13618  I ZCS N 1048576 + 0 [blkzone]
252,0   40       14     2.922199017  1058  D ZCS N 1048576 + 0 [kworker/40:1H]
252,0   40       15     2.922212873   212  C ZCS N 1048576 + 0 [0]
252,0   40       16     2.922222722 13618  Q ZCS N 1572864 + 0 [blkzone]
252,0   40       17     2.922226509 13618  G ZCS N 1572864 + 0 [blkzone]
252,0   40       18     2.922228733 13618  I ZCS N 1572864 + 0 [blkzone]
252,0   40       19     2.922243521  1058  D ZCS N 1572864 + 0 [kworker/40:1H]
252,0   40       20     2.922257106   212  C ZCS N 1572864 + 0 [0]
252,0   32        1     2.967036503 13624  Q ZRAS B 0 + 0 [blkzone]
252,0   32        2     2.967042303 13624  G ZRAS B 0 + 0 [blkzone]
252,0   32        3     2.967044568 13624  I ZRAS B 0 + 0 [blkzone]
252,0   32        4     2.967070186  1048  D ZRAS B 0 + 0 [kworker/32:1H]
252,0   32        5     2.967089762   172  C ZRAS B 0 + 0 [0]
252,0    9        1     2.994610132 13627  Q ZFS B 0 + 0 [blkzone]
252,0    9        2     2.994620161 13627  G ZFS B 0 + 0 [blkzone]
252,0    9        3     2.994624670 13627  I ZFS B 0 + 0 [blkzone]
252,0    9        4     2.994661839   799  D ZFS B 0 + 0 [kworker/9:1H]
252,0    9        5     2.994692216    57  C ZFS B 0 + 0 [0]
252,0    9        6     2.994711783 13627  Q ZFS B 524288 + 0 [blkzone]
252,0    9        7     2.994719207 13627  G ZFS B 524288 + 0 [blkzone]
252,0    9        8     2.994723445 13627  I ZFS B 524288 + 0 [blkzone]
252,0    9        9     2.994748121   799  D ZFS B 524288 + 0 [kworker/9:1H]
252,0    9       10     2.994770222    57  C ZFS B 524288 + 0 [0]
252,0    9       11     2.994786273 13627  Q ZFS B 1048576 + 0 [blkzone]
252,0    9       12     2.994792324 13627  G ZFS B 1048576 + 0 [blkzone]
252,0    9       13     2.994795700 13627  I ZFS B 1048576 + 0 [blkzone]
252,0    9       14     2.994823302   799  D ZFS B 1048576 + 0 [kworker/9:1H]
252,0    9       15     2.994845003    57  C ZFS B 1048576 + 0 [0]
252,0    9       16     2.994859660 13627  Q ZFS B 1572864 + 0 [blkzone]
252,0    9       17     2.994863768 13627  G ZFS B 1572864 + 0 [blkzone]
252,0    9       18     2.994865962 13627  I ZFS B 1572864 + 0 [blkzone]
252,0    9       19     2.994880028   799  D ZFS B 1572864 + 0 [kworker/9:1H]
252,0    9       20     2.994892562    57  C ZFS B 1572864 + 0 [0]
252,0    8        1     2.984513708 13626  Q ZCS B 0 + 0 [blkzone]
252,0    8        2     2.984520170 13626  G ZCS B 0 + 0 [blkzone]
252,0    8        3     2.984522745 13626  I ZCS B 0 + 0 [blkzone]
252,0    8        4     2.984549776  1721  D ZCS B 0 + 0 [kworker/8:1H]
252,0    8        5     2.984570244    52  C ZCS B 0 + 0 [0]
252,0    8        6     2.984580614 13626  Q ZCS B 524288 + 0 [blkzone]
252,0    8        7     2.984583960 13626  G ZCS B 524288 + 0 [blkzone]
252,0    8        8     2.984585843 13626  I ZCS B 524288 + 0 [blkzone]
252,0    8        9     2.984599419  1721  D ZCS B 524288 + 0 [kworker/8:1H]
252,0    8       10     2.984610971    52  C ZCS B 524288 + 0 [0]
252,0    8       11     2.984618955 13626  Q ZCS B 1048576 + 0 [blkzone]
252,0    8       12     2.984622272 13626  G ZCS B 1048576 + 0 [blkzone]
252,0    8       13     2.984624356 13626  I ZCS B 1048576 + 0 [blkzone]
252,0    8       14     2.984637731  1721  D ZCS B 1048576 + 0 [kworker/8:1H]
252,0    8       15     2.984649232    52  C ZCS B 1048576 + 0 [0]
252,0    8       16     2.984656997 13626  Q ZCS B 1572864 + 0 [blkzone]
252,0    8       17     2.984660073 13626  G ZCS B 1572864 + 0 [blkzone]
252,0    8       18     2.984661856 13626  I ZCS B 1572864 + 0 [blkzone]
252,0    8       19     2.984673347  1721  D ZCS B 1572864 + 0 [kworker/8:1H]
252,0    8       20     2.984684038    52  C ZCS B 1572864 + 0 [0]
252,0   34        1     2.975573312 13625  Q ZOS B 0 + 0 [blkzone]
252,0   34        2     2.975586376 13625  G ZOS B 0 + 0 [blkzone]
252,0   34        3     2.975590654 13625  I ZOS B 0 + 0 [blkzone]
252,0   34        4     2.975621863  1050  D ZOS B 0 + 0 [kworker/34:1H]
252,0   34        5     2.975643163   182  C ZOS B 0 + 0 [0]
252,0   34        6     2.975655917 13625  Q ZOS B 524288 + 0 [blkzone]
252,0   34        7     2.975659123 13625  G ZOS B 524288 + 0 [blkzone]
252,0   34        8     2.975660806 13625  I ZOS B 524288 + 0 [blkzone]
252,0   34        9     2.975675443  1050  D ZOS B 524288 + 0 [kworker/34:1H]
252,0   34       10     2.975686083   182  C ZOS B 524288 + 0 [0]
252,0   34       11     2.975693457 13625  Q ZOS B 1048576 + 0 [blkzone]
252,0   34       12     2.975696393 13625  G ZOS B 1048576 + 0 [blkzone]
252,0   34       13     2.975698076 13625  I ZOS B 1048576 + 0 [blkzone]
252,0   34       14     2.975709257  1050  D ZOS B 1048576 + 0 [kworker/34:1H]
252,0   34       15     2.975719236   182  C ZOS B 1048576 + 0 [0]
252,0   34       16     2.975726329 13625  Q ZOS B 1572864 + 0 [blkzone]
252,0   34       17     2.975729044 13625  G ZOS B 1572864 + 0 [blkzone]
252,0   34       18     2.975730647 13625  I ZOS B 1572864 + 0 [blkzone]
252,0   34       19     2.975740636  1050  D ZOS B 1572864 + 0 [kworker/34:1H]
252,0   34       20     2.975750685   182  C ZOS B 1572864 + 0 [0]
252,0   55        1     3.004754737 13628  Q ZRAS I 0 + 0 [blkzone]
252,0   55        2     3.004764024 13628  G ZRAS I 0 + 0 [blkzone]
252,0   55        3     3.004767851 13628  I ZRAS I 0 + 0 [blkzone]
252,0   28        1     3.004787769 13617  D ZRAS I 0 + 0 [systemd-udevd]
252,0   55        4     3.004819388 13628  C ZRAS I 0 + 0 [0]
252,0   34       21     3.014233563 13629  Q ZOS I 0 + 0 [blkzone]
252,0   34       22     3.014239444 13629  G ZOS I 0 + 0 [blkzone]
252,0   34       23     3.014241588 13629  I ZOS I 0 + 0 [blkzone]
252,0   34       24     3.014262156  1050  D ZOS I 0 + 0 [kworker/34:1H]
252,0   34       25     3.014277475   182  C ZOS I 0 + 0 [0]
252,0   36        1     3.024664655 13630  Q ZCS I 0 + 0 [blkzone]
252,0   36        2     3.024679242 13630  G ZCS I 0 + 0 [blkzone]
252,0   36        3     3.024683289 13630  I ZCS I 0 + 0 [blkzone]
252,0   36        4     3.024721902   925  D ZCS I 0 + 0 [kworker/36:1H]
252,0   36        5     3.024747951   192  C ZCS I 0 + 0 [0]
252,0   36        6     3.024763420 13630  Q ZCS I 524288 + 0 [blkzone]
252,0   36        7     3.024767588 13630  G ZCS I 524288 + 0 [blkzone]
252,0   36        8     3.024769782 13630  I ZCS I 524288 + 0 [blkzone]
252,0   36        9     3.024786794   925  D ZCS I 524288 + 0 [kworker/36:1H]
252,0   36       10     3.024800229   192  C ZCS I 524288 + 0 [0]
252,0   36       11     3.024809887 13630  Q ZCS I 1048576 + 0 [blkzone]
252,0   36       12     3.024813644 13630  G ZCS I 1048576 + 0 [blkzone]
252,0   36       13     3.024815638 13630  I ZCS I 1048576 + 0 [blkzone]
252,0   36       14     3.024830676   925  D ZCS I 1048576 + 0 [kworker/36:1H]
252,0   36       15     3.024843159   192  C ZCS I 1048576 + 0 [0]
252,0   36       16     3.024852166 13630  Q ZCS I 1572864 + 0 [blkzone]
252,0   36       17     3.024855573 13630  G ZCS I 1572864 + 0 [blkzone]
252,0   36       18     3.024857606 13630  I ZCS I 1572864 + 0 [blkzone]
252,0   36       19     3.024871372   925  D ZCS I 1572864 + 0 [kworker/36:1H]
252,0   36       20     3.024883946   192  C ZCS I 1572864 + 0 [0]
252,0   39        1     3.034360768 13631  Q ZFS I 0 + 0 [blkzone]
252,0   39        2     3.034368502 13631  G ZFS I 0 + 0 [blkzone]
252,0   39        3     3.034371859 13631  I ZFS I 0 + 0 [blkzone]
252,0   39        4     3.034406844   533  D ZFS I 0 + 0 [kworker/39:1H]
252,0   39        5     3.034430669   207  C ZFS I 0 + 0 [0]
252,0   39        6     3.034444866 13631  Q ZFS I 524288 + 0 [blkzone]
252,0   39        7     3.034449064 13631  G ZFS I 524288 + 0 [blkzone]
252,0   39        8     3.034451468 13631  I ZFS I 524288 + 0 [blkzone]
252,0   39        9     3.034469141   533  D ZFS I 524288 + 0 [kworker/39:1H]
252,0   39       10     3.034484169   207  C ZFS I 524288 + 0 [0]
252,0   39       11     3.034530055 13631  Q ZFS I 1048576 + 0 [blkzone]
252,0   39       12     3.034534895 13631  G ZFS I 1048576 + 0 [blkzone]
252,0   39       13     3.034537439 13631  I ZFS I 1048576 + 0 [blkzone]
252,0   39       14     3.034554091   533  D ZFS I 1048576 + 0 [kworker/39:1H]
252,0   39       15     3.034569249   207  C ZFS I 1048576 + 0 [0]
252,0   39       16     3.034582384 13631  Q ZFS I 1572864 + 0 [blkzone]
252,0   39       17     3.034586461 13631  G ZFS I 1572864 + 0 [blkzone]
252,0   39       18     3.034588685 13631  I ZFS I 1572864 + 0 [blkzone]
252,0   39       19     3.034604735   533  D ZFS I 1572864 + 0 [kworker/39:1H]
252,0   39       20     3.034618752   207  C ZFS I 1572864 + 0 [0]
252,0   34       26     3.014335975 13629  Q ZOS I 524288 + 0 [blkzone]
252,0   34       27     3.014339071 13629  G ZOS I 524288 + 0 [blkzone]
252,0   34       28     3.014340513 13629  I ZOS I 524288 + 0 [blkzone]
252,0   34       29     3.014352426  1050  D ZOS I 524288 + 0 [kworker/34:1H]
252,0   34       30     3.014362244   182  C ZOS I 524288 + 0 [0]
252,0    3        1     3.014384396 13629  Q ZOS I 1048576 + 0 [blkzone]
252,0    3        2     3.014391679 13629  G ZOS I 1048576 + 0 [blkzone]
252,0    3        3     3.014394915 13629  I ZOS I 1048576 + 0 [blkzone]
252,0    3        4     3.014425513  1737  D ZOS I 1048576 + 0 [kworker/3:1H]
252,0    3        5     3.014449728    27  C ZOS I 1048576 + 0 [0]
252,0    3        6     3.014466470 13629  Q ZOS I 1572864 + 0 [blkzone]
252,0    3        7     3.014470577 13629  G ZOS I 1572864 + 0 [blkzone]
252,0    3        8     3.014473002 13629  I ZOS I 1572864 + 0 [blkzone]
252,0    3        9     3.014543774  1737  D ZOS I 1572864 + 0 [kworker/3:1H]
252,0    3       10     3.014563752    27  C ZOS I 1572864 + 0 [0]
CPU1 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU2 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU3 (252,0):
 Reads Queued:           2,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        2,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        2,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU4 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU5 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU8 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU9 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU28 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU32 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU34 (252,0):
 Reads Queued:           6,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        6,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        6,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU36 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU39 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU40 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU55 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             1        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          39,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       39,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       39,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 195 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xE
---------------------------------------------
252,0   48        1     2.937939586 13709  Q ZRAS R 0 + 0 [blkzone]
252,0   48        2     2.937944115 13709  G ZRAS R 0 + 0 [blkzone]
252,0   48        3     2.937945768 13709  I ZRAS R 0 + 0 [blkzone]
252,0   48        4     2.937962259   831  D ZRAS R 0 + 0 [kworker/48:1H]
252,0   48        5     2.937974562   252  C ZRAS R 0 + 0 [0]
252,0   52        1     2.946681400 13710  Q ZOS R 0 + 0 [blkzone]
252,0   52        2     2.946690858 13710  G ZOS R 0 + 0 [blkzone]
252,0   52        3     2.946694204 13710  I ZOS R 0 + 0 [blkzone]
252,0   52        4     2.946731344  1094  C ZOS R 0 + 0 [0]
252,0   52        5     2.946753195 13710  Q ZOS R 524288 + 0 [blkzone]
252,0   52        6     2.946757733 13710  G ZOS R 524288 + 0 [blkzone]
252,0   52        7     2.946759988 13710  I ZOS R 524288 + 0 [blkzone]
252,0   52        8     2.946777280  1094  D ZOS R 524288 + 0 [kworker/52:1H]
252,0   52        9     2.946797859   272  C ZOS R 524288 + 0 [0]
252,0   52       10     2.946808879 13710  Q ZOS R 1048576 + 0 [blkzone]
252,0   52       11     2.946813428 13710  G ZOS R 1048576 + 0 [blkzone]
252,0   52       12     2.946815552 13710  I ZOS R 1048576 + 0 [blkzone]
252,0   52       13     2.946830861  1094  D ZOS R 1048576 + 0 [kworker/52:1H]
252,0   52       14     2.946844506   272  C ZOS R 1048576 + 0 [0]
252,0   52       15     2.946853894 13710  Q ZOS R 1572864 + 0 [blkzone]
252,0   52       16     2.946858001 13710  G ZOS R 1572864 + 0 [blkzone]
252,0   52       17     2.946860005 13710  I ZOS R 1572864 + 0 [blkzone]
252,0   52       18     2.946872879  1094  D ZOS R 1572864 + 0 [kworker/52:1H]
252,0   52       19     2.946885393   272  C ZOS R 1572864 + 0 [0]
252,0   49        1     2.956433859 13711  Q ZCS R 0 + 0 [blkzone]
252,0   49        2     2.956441594 13711  G ZCS R 0 + 0 [blkzone]
252,0   49        3     2.956444850 13711  I ZCS R 0 + 0 [blkzone]
252,0   49        4     2.956478182   834  D ZCS R 0 + 0 [kworker/49:1H]
252,0   49        5     2.956499793   257  C ZCS R 0 + 0 [0]
252,0   49        6     2.956513419 13711  Q ZCS R 524288 + 0 [blkzone]
252,0   49        7     2.956517296 13711  G ZCS R 524288 + 0 [blkzone]
252,0   49        8     2.956519430 13711  I ZCS R 524288 + 0 [blkzone]
252,0   49        9     2.956587538   834  D ZCS R 524288 + 0 [kworker/49:1H]
252,0   49       10     2.956602445   257  C ZCS R 524288 + 0 [0]
252,0   49       11     2.956613075 13711  Q ZCS R 1048576 + 0 [blkzone]
252,0   49       12     2.956617343 13711  G ZCS R 1048576 + 0 [blkzone]
252,0   49       13     2.956619548 13711  I ZCS R 1048576 + 0 [blkzone]
252,0   49       14     2.956636259   834  D ZCS R 1048576 + 0 [kworker/49:1H]
252,0   49       15     2.956648983   257  C ZCS R 1048576 + 0 [0]
252,0   49       16     2.956658010 13711  Q ZCS R 1572864 + 0 [blkzone]
252,0   49       17     2.956661707 13711  G ZCS R 1572864 + 0 [blkzone]
252,0   49       18     2.956663801 13711  I ZCS R 1572864 + 0 [blkzone]
252,0   49       19     2.956678097   834  D ZCS R 1572864 + 0 [kworker/49:1H]
252,0   49       20     2.956690471   257  C ZCS R 1572864 + 0 [0]
252,0   28        1     2.946702640 13707  D ZOS R 0 + 0 [systemd-udevd]
252,0   43        1     2.966632205 13712  Q ZFS R 0 + 0 [blkzone]
252,0   43        2     2.966640440 13712  G ZFS R 0 + 0 [blkzone]
252,0   43        3     2.966643766 13712  I ZFS R 0 + 0 [blkzone]
252,0   43        4     2.966681207   817  D ZFS R 0 + 0 [kworker/43:1H]
252,0   43        5     2.966704170   227  C ZFS R 0 + 0 [0]
252,0   43        6     2.966718246 13712  Q ZFS R 524288 + 0 [blkzone]
252,0   43        7     2.966722805 13712  G ZFS R 524288 + 0 [blkzone]
252,0   43        8     2.966726842 13712  I ZFS R 524288 + 0 [blkzone]
252,0   43        9     2.966756708 13712  C ZFS R 524288 + 0 [0]
252,0   43       10     2.966763912 13712  Q ZFS R 1048576 + 0 [blkzone]
252,0   43       11     2.966768731 13712  G ZFS R 1048576 + 0 [blkzone]
252,0   43       12     2.966770805 13712  I ZFS R 1048576 + 0 [blkzone]
252,0   43       13     2.966786013   817  D ZFS R 1048576 + 0 [kworker/43:1H]
252,0   43       14     2.966799508   227  C ZFS R 1048576 + 0 [0]
252,0   43       15     2.966808656 13712  Q ZFS R 1572864 + 0 [blkzone]
252,0   43       16     2.966813024 13712  G ZFS R 1572864 + 0 [blkzone]
252,0   43       17     2.966818203 13712  I ZFS R 1572864 + 0 [blkzone]
252,0   43       18     2.966844222 13712  C ZFS R 1572864 + 0 [0]
252,0   53        1     2.975310850 13713  Q ZRAS B 0 + 0 [blkzone]
252,0   53        2     2.975321760 13713  G ZRAS B 0 + 0 [blkzone]
252,0   53        3     2.975324926 13713  I ZRAS B 0 + 0 [blkzone]
252,0   53        4     2.975364761  1092  D ZRAS B 0 + 0 [kworker/53:1H]
252,0   53        5     2.975387794   277  C ZRAS B 0 + 0 [0]
252,0   51        1     2.993618463 13715  Q ZCS B 0 + 0 [blkzone]
252,0   51        2     2.993625716 13715  G ZCS B 0 + 0 [blkzone]
252,0   51        3     2.993629113 13715  I ZCS B 0 + 0 [blkzone]
252,0   51        4     2.993661614   822  D ZCS B 0 + 0 [kworker/51:1H]
252,0   51        5     2.993684086   267  C ZCS B 0 + 0 [0]
252,0   51        6     2.993697701 13715  Q ZCS B 524288 + 0 [blkzone]
252,0   51        7     2.993701849 13715  G ZCS B 524288 + 0 [blkzone]
252,0   51        8     2.993704244 13715  I ZCS B 524288 + 0 [blkzone]
252,0   51        9     2.993722197   822  D ZCS B 524288 + 0 [kworker/51:1H]
252,0   51       10     2.993736705   267  C ZCS B 524288 + 0 [0]
252,0   51       11     2.993746954 13715  Q ZCS B 1048576 + 0 [blkzone]
252,0   51       12     2.993750971 13715  G ZCS B 1048576 + 0 [blkzone]
252,0   51       13     2.993753206 13715  I ZCS B 1048576 + 0 [blkzone]
252,0   51       14     2.993769706   822  D ZCS B 1048576 + 0 [kworker/51:1H]
252,0   51       15     2.993783693   267  C ZCS B 1048576 + 0 [0]
252,0   51       16     2.993793501 13715  Q ZCS B 1572864 + 0 [blkzone]
252,0   51       17     2.993797509 13715  G ZCS B 1572864 + 0 [blkzone]
252,0   51       18     2.993799693 13715  I ZCS B 1572864 + 0 [blkzone]
252,0   51       19     2.993814390   822  D ZCS B 1572864 + 0 [kworker/51:1H]
252,0   51       20     2.993827856   267  C ZCS B 1572864 + 0 [0]
252,0   50        1     3.002792968 13716  Q ZFS B 0 + 0 [blkzone]
252,0   50        2     3.002800452 13716  G ZFS B 0 + 0 [blkzone]
252,0   50        3     3.002803658 13716  I ZFS B 0 + 0 [blkzone]
252,0   50        4     3.002833634   840  D ZFS B 0 + 0 [kworker/50:1H]
252,0   50        5     3.002856247   262  C ZFS B 0 + 0 [0]
252,0   50        6     3.002869191 13716  Q ZFS B 524288 + 0 [blkzone]
252,0   50        7     3.002873469 13716  G ZFS B 524288 + 0 [blkzone]
252,0   50        8     3.002875653 13716  I ZFS B 524288 + 0 [blkzone]
252,0   50        9     3.002891663   840  D ZFS B 524288 + 0 [kworker/50:1H]
252,0   50       10     3.002905259   262  C ZFS B 524288 + 0 [0]
252,0   50       11     3.002914817 13716  Q ZFS B 1048576 + 0 [blkzone]
252,0   50       12     3.002918664 13716  G ZFS B 1048576 + 0 [blkzone]
252,0   50       13     3.002920708 13716  I ZFS B 1048576 + 0 [blkzone]
252,0   50       14     3.002934914   840  D ZFS B 1048576 + 0 [kworker/50:1H]
252,0   50       15     3.002947578   262  C ZFS B 1048576 + 0 [0]
252,0   50       16     3.002956515 13716  Q ZFS B 1572864 + 0 [blkzone]
252,0   50       17     3.002960061 13716  G ZFS B 1572864 + 0 [blkzone]
252,0   50       18     3.002962075 13716  I ZFS B 1572864 + 0 [blkzone]
252,0   50       19     3.002974699   840  D ZFS B 1572864 + 0 [kworker/50:1H]
252,0   50       20     3.002987012   262  C ZFS B 1572864 + 0 [0]
252,0   28        2     2.966737141 13707  D ZFS R 524288 + 0 [systemd-udevd]
252,0   28        3     2.966829084 13707  D ZFS R 1572864 + 0 [systemd-udevd]
252,0   58        1     2.984232060 13714  Q ZOS B 0 + 0 [blkzone]
252,0   58        2     2.984239043 13714  G ZOS B 0 + 0 [blkzone]
252,0   58        3     2.984241648 13714  I ZOS B 0 + 0 [blkzone]
252,0   58        4     2.984267266   816  D ZOS B 0 + 0 [kworker/58:1H]
252,0   58        5     2.984287995   302  C ZOS B 0 + 0 [0]
252,0   58        6     2.984304536 13714  Q ZOS B 524288 + 0 [blkzone]
252,0   58        7     2.984308003 13714  G ZOS B 524288 + 0 [blkzone]
252,0   58        8     2.984309726 13714  I ZOS B 524288 + 0 [blkzone]
252,0   58        9     2.984322440   816  D ZOS B 524288 + 0 [kworker/58:1H]
252,0   58       10     2.984332909   302  C ZOS B 524288 + 0 [0]
252,0   58       11     2.984340834 13714  Q ZOS B 1048576 + 0 [blkzone]
252,0   58       12     2.984343940 13714  G ZOS B 1048576 + 0 [blkzone]
252,0   58       13     2.984345603 13714  I ZOS B 1048576 + 0 [blkzone]
252,0   58       14     2.984356704   816  D ZOS B 1048576 + 0 [kworker/58:1H]
252,0   58       15     2.984366713   302  C ZOS B 1048576 + 0 [0]
252,0   58       16     2.984373676 13714  Q ZOS B 1572864 + 0 [blkzone]
252,0   58       17     2.984376752 13714  G ZOS B 1572864 + 0 [blkzone]
252,0   58       18     2.984378325 13714  I ZOS B 1572864 + 0 [blkzone]
252,0   58       19     2.984388484   816  D ZOS B 1572864 + 0 [kworker/58:1H]
252,0   58       20     2.984398472   302  C ZOS B 1572864 + 0 [0]
252,0   54        1     3.012200540 13717  Q ZRAS I 0 + 0 [blkzone]
252,0   54        2     3.012207934 13717  G ZRAS I 0 + 0 [blkzone]
252,0   54        3     3.012211170 13717  I ZRAS I 0 + 0 [blkzone]
252,0   54        4     3.012243190  1397  D ZRAS I 0 + 0 [kworker/54:1H]
252,0   54        5     3.012267626   282  C ZRAS I 0 + 0 [0]
252,0    1        1     3.041679333 13720  Q ZFS I 0 + 0 [blkzone]
252,0    1        2     3.041688510 13720  G ZFS I 0 + 0 [blkzone]
252,0    1        3     3.041691726 13720  I ZFS I 0 + 0 [blkzone]
252,0    1        4     3.041722264  1581  D ZFS I 0 + 0 [kworker/1:1H]
252,0    1        5     3.041744635    17  C ZFS I 0 + 0 [0]
252,0    1        6     3.041757950 13720  Q ZFS I 524288 + 0 [blkzone]
252,0    1        7     3.041761778 13720  G ZFS I 524288 + 0 [blkzone]
252,0    1        8     3.041764072 13720  I ZFS I 524288 + 0 [blkzone]
252,0    1        9     3.041779160  1581  D ZFS I 524288 + 0 [kworker/1:1H]
252,0    1       10     3.041792375    17  C ZFS I 524288 + 0 [0]
252,0    1       11     3.041801873 13720  Q ZFS I 1048576 + 0 [blkzone]
252,0    1       12     3.041806151 13720  G ZFS I 1048576 + 0 [blkzone]
252,0    1       13     3.041808245 13720  I ZFS I 1048576 + 0 [blkzone]
252,0    1       14     3.041822171  1581  D ZFS I 1048576 + 0 [kworker/1:1H]
252,0    1       15     3.041834795    17  C ZFS I 1048576 + 0 [0]
252,0    1       16     3.041843791 13720  Q ZFS I 1572864 + 0 [blkzone]
252,0    1       17     3.041847238 13720  G ZFS I 1572864 + 0 [blkzone]
252,0    1       18     3.041849222 13720  I ZFS I 1572864 + 0 [blkzone]
252,0    1       19     3.041861945  1581  D ZFS I 1572864 + 0 [kworker/1:1H]
252,0    1       20     3.041874138    17  C ZFS I 1572864 + 0 [0]
252,0   61        1     3.022631542 13718  Q ZOS I 0 + 0 [blkzone]
252,0   61        2     3.022641030 13718  G ZOS I 0 + 0 [blkzone]
252,0   61        3     3.022645478 13718  I ZOS I 0 + 0 [blkzone]
252,0   61        4     3.022685143  1027  D ZOS I 0 + 0 [kworker/61:1H]
252,0   61        5     3.022714598   317  C ZOS I 0 + 0 [0]
252,0   61        6     3.022732281 13718  Q ZOS I 524288 + 0 [blkzone]
252,0   61        7     3.022738172 13718  G ZOS I 524288 + 0 [blkzone]
252,0   61        8     3.022741418 13718  I ZOS I 524288 + 0 [blkzone]
252,0   61        9     3.022763530  1027  D ZOS I 524288 + 0 [kworker/61:1H]
252,0   61       10     3.022783317   317  C ZOS I 524288 + 0 [0]
252,0   61       11     3.022796972 13718  Q ZOS I 1048576 + 0 [blkzone]
252,0   61       12     3.022802042 13718  G ZOS I 1048576 + 0 [blkzone]
252,0   61       13     3.022805098 13718  I ZOS I 1048576 + 0 [blkzone]
252,0   61       14     3.022825055  1027  D ZOS I 1048576 + 0 [kworker/61:1H]
252,0   61       15     3.022843279   317  C ZOS I 1048576 + 0 [0]
252,0   61       16     3.022856424 13718  Q ZOS I 1572864 + 0 [blkzone]
252,0   61       17     3.022861624 13718  G ZOS I 1572864 + 0 [blkzone]
252,0   61       18     3.022864559 13718  I ZOS I 1572864 + 0 [blkzone]
252,0   61       19     3.022882793  1027  D ZOS I 1572864 + 0 [kworker/61:1H]
252,0   61       20     3.022900396   317  C ZOS I 1572864 + 0 [0]
252,0   62        1     3.032627598 13719  Q ZCS I 0 + 0 [blkzone]
252,0   62        2     3.032634180 13719  G ZCS I 0 + 0 [blkzone]
252,0   62        3     3.032637487 13719  I ZCS I 0 + 0 [blkzone]
252,0   62        4     3.032670398   826  D ZCS I 0 + 0 [kworker/62:1H]
252,0   62        5     3.032693301   383  C ZCS I 0 + 0 [0]
252,0   62        6     3.032707157 13719  Q ZCS I 524288 + 0 [blkzone]
252,0   62        7     3.032711265 13719  G ZCS I 524288 + 0 [blkzone]
252,0   62        8     3.032713659 13719  I ZCS I 524288 + 0 [blkzone]
252,0   62        9     3.032731192   826  D ZCS I 524288 + 0 [kworker/62:1H]
252,0   62       10     3.032745990   383  C ZCS I 524288 + 0 [0]
252,0   62       11     3.032756490 13719  Q ZCS I 1048576 + 0 [blkzone]
252,0   62       12     3.032760387 13719  G ZCS I 1048576 + 0 [blkzone]
252,0   62       13     3.032762631 13719  I ZCS I 1048576 + 0 [blkzone]
252,0   62       14     3.032779082   826  D ZCS I 1048576 + 0 [kworker/62:1H]
252,0   62       15     3.032793399   383  C ZCS I 1048576 + 0 [0]
252,0   62       16     3.032804269 13719  Q ZCS I 1572864 + 0 [blkzone]
252,0   62       17     3.032808127 13719  G ZCS I 1572864 + 0 [blkzone]
252,0   62       18     3.032810351 13719  I ZCS I 1572864 + 0 [blkzone]
252,0   62       19     3.032826671   826  D ZCS I 1572864 + 0 [kworker/62:1H]
252,0   62       20     3.032839986   383  C ZCS I 1572864 + 0 [0]
CPU1 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU28 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        3,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU43 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        2,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU44 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU48 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU49 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU50 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU51 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU52 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        3,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU53 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU54 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU58 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU61 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU62 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          39,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       39,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       39,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 195 entries
Skips: 0 forward (0 -   0.0%)
---------------------------------------------
Using Priority mask 0xF
---------------------------------------------
252,0   25        1     2.898365441 13793  Q ZRAS N 0 + 0 [blkzone]
252,0   25        2     2.898387182 13793  G ZRAS N 0 + 0 [blkzone]
252,0   25        3     2.898390939 13793  I ZRAS N 0 + 0 [blkzone]
252,0   25        4     2.898424462  1053  D ZRAS N 0 + 0 [kworker/25:1H]
252,0   25        5     2.898462994   137  C ZRAS N 0 + 0 [0]
252,0   26        1     2.906177652 13794  Q ZOS N 0 + 0 [blkzone]
252,0   26        2     2.906182591 13794  G ZOS N 0 + 0 [blkzone]
252,0   26        3     2.906184445 13794  I ZOS N 0 + 0 [blkzone]
252,0   26        4     2.906203641   830  D ZOS N 0 + 0 [kworker/26:1H]
252,0   26        5     2.906227515   142  C ZOS N 0 + 0 [0]
252,0   26        6     2.906235090 13794  Q ZOS N 524288 + 0 [blkzone]
252,0   26        7     2.906237464 13794  G ZOS N 524288 + 0 [blkzone]
252,0   26        8     2.906238696 13794  I ZOS N 524288 + 0 [blkzone]
252,0   26        9     2.906247563   830  D ZOS N 524288 + 0 [kworker/26:1H]
252,0   26       10     2.906254967   142  C ZOS N 524288 + 0 [0]
252,0   26       11     2.906260177 13794  Q ZOS N 1048576 + 0 [blkzone]
252,0   26       12     2.906262451 13794  G ZOS N 1048576 + 0 [blkzone]
252,0   26       13     2.906263583 13794  I ZOS N 1048576 + 0 [blkzone]
252,0   26       14     2.906271268   830  D ZOS N 1048576 + 0 [kworker/26:1H]
252,0   26       15     2.906278221   142  C ZOS N 1048576 + 0 [0]
252,0   26       16     2.906283260 13794  Q ZOS N 1572864 + 0 [blkzone]
252,0   26       17     2.906285234 13794  G ZOS N 1572864 + 0 [blkzone]
252,0   26       18     2.906286336 13794  I ZOS N 1572864 + 0 [blkzone]
252,0   26       19     2.906293269   830  D ZOS N 1572864 + 0 [kworker/26:1H]
252,0   26       20     2.906299881   142  C ZOS N 1572864 + 0 [0]
252,0   26       21     2.912736933 13795  Q ZCS N 0 + 0 [blkzone]
252,0   26       22     2.912740149 13795  G ZCS N 0 + 0 [blkzone]
252,0   26       23     2.912742724 13795  I ZCS N 0 + 0 [blkzone]
252,0   26       24     2.912786897 13754  C ZCS N 0 + 0 [0]
252,0   30        1     2.912768582 13796  D ZCS N 0 + 0 [systemd-udevd]
252,0   30        2     2.912909126 13796  D ZCS N 1048576 + 0 [systemd-udevd]
252,0   22        1     2.954921242 13801  Q ZFS R 0 + 0 [blkzone]
252,0   22        2     2.954929027 13801  G ZFS R 0 + 0 [blkzone]
252,0   22        3     2.954932223 13801  I ZFS R 0 + 0 [blkzone]
252,0   22        4     2.954963692   934  D ZFS R 0 + 0 [kworker/22:1H]
252,0   22        5     2.955005320   122  C ZFS R 0 + 0 [0]
252,0   22        6     2.955023885 13801  Q ZFS R 524288 + 0 [blkzone]
252,0   22        7     2.955028033 13801  G ZFS R 524288 + 0 [blkzone]
252,0   22        8     2.955030327 13801  I ZFS R 524288 + 0 [blkzone]
252,0   22        9     2.955046487   934  D ZFS R 524288 + 0 [kworker/22:1H]
252,0   22       10     2.955060133   122  C ZFS R 524288 + 0 [0]
252,0   22       11     2.955069681 13801  Q ZFS R 1048576 + 0 [blkzone]
252,0   22       12     2.955073388 13801  G ZFS R 1048576 + 0 [blkzone]
252,0   22       13     2.955075422 13801  I ZFS R 1048576 + 0 [blkzone]
252,0   22       14     2.955089588   934  D ZFS R 1048576 + 0 [kworker/22:1H]
252,0   22       15     2.955102212   122  C ZFS R 1048576 + 0 [0]
252,0   22       16     2.955111239 13801  Q ZFS R 1572864 + 0 [blkzone]
252,0   22       17     2.955114695 13801  G ZFS R 1572864 + 0 [blkzone]
252,0   22       18     2.955116729 13801  I ZFS R 1572864 + 0 [blkzone]
252,0   22       19     2.955129273   934  D ZFS R 1572864 + 0 [kworker/22:1H]
252,0   22       20     2.955142177   122  C ZFS R 1572864 + 0 [0]
252,0   26       25     2.912850426 13795  Q ZCS N 524288 + 0 [blkzone]
252,0   26       26     2.912853812 13795  G ZCS N 524288 + 0 [blkzone]
252,0   26       27     2.912855585 13795  I ZCS N 524288 + 0 [blkzone]
252,0   26       28     2.912870874   830  D ZCS N 524288 + 0 [kworker/26:1H]
252,0   26       29     2.912885892   142  C ZCS N 524288 + 0 [0]
252,0   26       30     2.912894047 13795  Q ZCS N 1048576 + 0 [blkzone]
252,0   26       31     2.912897364 13795  G ZCS N 1048576 + 0 [blkzone]
252,0   26       32     2.912899087 13795  I ZCS N 1048576 + 0 [blkzone]
252,0   26       33     2.912917952 13795  C ZCS N 1048576 + 0 [0]
252,0   26       34     2.912922861 13795  Q ZCS N 1572864 + 0 [blkzone]
252,0   26       35     2.912925907 13795  G ZCS N 1572864 + 0 [blkzone]
252,0   26       36     2.912927761 13795  I ZCS N 1572864 + 0 [blkzone]
252,0   26       37     2.912939513   830  D ZCS N 1572864 + 0 [kworker/26:1H]
252,0   26       38     2.912950073   142  C ZCS N 1572864 + 0 [0]
252,0   26       39     2.920742776 13797  Q ZFS N 0 + 0 [blkzone]
252,0   26       40     2.920748116 13797  G ZFS N 0 + 0 [blkzone]
252,0   26       41     2.920750641 13797  I ZFS N 0 + 0 [blkzone]
252,0   26       42     2.920773384   830  D ZFS N 0 + 0 [kworker/26:1H]
252,0   26       43     2.920791327   142  C ZFS N 0 + 0 [0]
252,0   26       44     2.920802018 13797  Q ZFS N 524288 + 0 [blkzone]
252,0   26       45     2.920805344 13797  G ZFS N 524288 + 0 [blkzone]
252,0   26       46     2.920807247 13797  I ZFS N 524288 + 0 [blkzone]
252,0   26       47     2.920819280   830  D ZFS N 524288 + 0 [kworker/26:1H]
252,0   26       48     2.920830291   142  C ZFS N 524288 + 0 [0]
252,0   26       49     2.920838195 13797  Q ZFS N 1048576 + 0 [blkzone]
252,0   26       50     2.920841602 13797  G ZFS N 1048576 + 0 [blkzone]
252,0   26       51     2.920843345 13797  I ZFS N 1048576 + 0 [blkzone]
252,0   26       52     2.920855207   830  D ZFS N 1048576 + 0 [kworker/26:1H]
252,0   26       53     2.920865607   142  C ZFS N 1048576 + 0 [0]
252,0   26       54     2.920875876 13797  Q ZFS N 1572864 + 0 [blkzone]
252,0   26       55     2.920880034 13797  G ZFS N 1572864 + 0 [blkzone]
252,0   26       56     2.920882358 13797  I ZFS N 1572864 + 0 [blkzone]
252,0   26       57     2.920893669   830  D ZFS N 1572864 + 0 [kworker/26:1H]
252,0   26       58     2.920904951   142  C ZFS N 1572864 + 0 [0]
252,0   14        1     2.926433679 13798  Q ZRAS R 0 + 0 [blkzone]
252,0   14        2     2.926438217 13798  G ZRAS R 0 + 0 [blkzone]
252,0   14        3     2.926440181 13798  I ZRAS R 0 + 0 [blkzone]
252,0   14        4     2.926460609   956  D ZRAS R 0 + 0 [kworker/14:1H]
252,0   14        5     2.926485967    82  C ZRAS R 0 + 0 [0]
252,0   39        1     2.945420225 13800  Q ZCS R 0 + 0 [blkzone]
252,0   39        2     2.945426036 13800  G ZCS R 0 + 0 [blkzone]
252,0   39        3     2.945428410 13800  I ZCS R 0 + 0 [blkzone]
252,0   39        4     2.945466331   533  D ZCS R 0 + 0 [kworker/39:1H]
252,0   39        5     2.945496007   207  C ZCS R 0 + 0 [0]
252,0   39        6     2.945510033 13800  Q ZCS R 524288 + 0 [blkzone]
252,0   39        7     2.945513410 13800  G ZCS R 524288 + 0 [blkzone]
252,0   39        8     2.945515213 13800  I ZCS R 524288 + 0 [blkzone]
252,0   39        9     2.945528859   533  D ZCS R 524288 + 0 [kworker/39:1H]
252,0   39       10     2.945539829   207  C ZCS R 524288 + 0 [0]
252,0   39       11     2.945547504 13800  Q ZCS R 1048576 + 0 [blkzone]
252,0   39       12     2.945550439 13800  G ZCS R 1048576 + 0 [blkzone]
252,0   39       13     2.945552022 13800  I ZCS R 1048576 + 0 [blkzone]
252,0   39       14     2.945563854   533  D ZCS R 1048576 + 0 [kworker/39:1H]
252,0   39       15     2.945573592   207  C ZCS R 1048576 + 0 [0]
252,0   39       16     2.945580696 13800  Q ZCS R 1572864 + 0 [blkzone]
252,0   39       17     2.945583501 13800  G ZCS R 1572864 + 0 [blkzone]
252,0   39       18     2.945585094 13800  I ZCS R 1572864 + 0 [blkzone]
252,0   39       19     2.945595634   533  D ZCS R 1572864 + 0 [kworker/39:1H]
252,0   39       20     2.945605362   207  C ZCS R 1572864 + 0 [0]
252,0   25        6     2.961007546 13802  Q ZRAS B 0 + 0 [blkzone]
252,0   25        7     2.961011574 13802  G ZRAS B 0 + 0 [blkzone]
252,0   25        8     2.961013387 13802  I ZRAS B 0 + 0 [blkzone]
252,0   25        9     2.961032052  1053  D ZRAS B 0 + 0 [kworker/25:1H]
252,0   25       10     2.961045217   137  C ZRAS B 0 + 0 [0]
252,0    5        1     2.935894471 13799  Q ZOS R 0 + 0 [blkzone]
252,0    5        2     2.935901414 13799  G ZOS R 0 + 0 [blkzone]
252,0    5        3     2.935904870 13799  I ZOS R 0 + 0 [blkzone]
252,0    5        4     2.935938614  1507  D ZOS R 0 + 0 [kworker/5:1H]
252,0    5        5     2.935980853    37  C ZOS R 0 + 0 [0]
252,0    5        6     2.935995631 13799  Q ZOS R 524288 + 0 [blkzone]
252,0    5        7     2.936002584 13799  G ZOS R 524288 + 0 [blkzone]
252,0    5        8     2.936005339 13799  I ZOS R 524288 + 0 [blkzone]
252,0    5        9     2.936038691 13799  C ZOS R 524288 + 0 [0]
252,0    5       10     2.936046085 13799  Q ZOS R 1048576 + 0 [blkzone]
252,0    5       11     2.936050604 13799  G ZOS R 1048576 + 0 [blkzone]
252,0    5       12     2.936053008 13799  I ZOS R 1048576 + 0 [blkzone]
252,0    5       13     2.936070180  1507  D ZOS R 1048576 + 0 [kworker/5:1H]
252,0    5       14     2.936085619    37  C ZOS R 1048576 + 0 [0]
252,0    5       15     2.936095959 13799  Q ZOS R 1572864 + 0 [blkzone]
252,0    5       16     2.936099926 13799  G ZOS R 1572864 + 0 [blkzone]
252,0    5       17     2.936102431 13799  I ZOS R 1572864 + 0 [blkzone]
252,0    5       18     2.936131285 13799  C ZOS R 1572864 + 0 [0]
252,0   30        3     2.936016941 13796  D ZOS R 524288 + 0 [systemd-udevd]
252,0   30        4     2.936112600 13796  D ZOS R 1572864 + 0 [systemd-udevd]
252,0   32        1     2.989467308 13805  Q ZFS B 0 + 0 [blkzone]
252,0   32        2     2.989473890 13805  G ZFS B 0 + 0 [blkzone]
252,0   32        3     2.989477236 13805  I ZFS B 0 + 0 [blkzone]
252,0   32        4     2.989510900  1048  D ZFS B 0 + 0 [kworker/32:1H]
252,0   32        5     2.989555323   172  C ZFS B 0 + 0 [0]
252,0   32        6     2.989569309 13805  Q ZFS B 524288 + 0 [blkzone]
252,0   32        7     2.989573687 13805  G ZFS B 524288 + 0 [blkzone]
252,0   32        8     2.989576042 13805  I ZFS B 524288 + 0 [blkzone]
252,0   32        9     2.989592453  1048  D ZFS B 524288 + 0 [kworker/32:1H]
252,0   32       10     2.989606639   172  C ZFS B 524288 + 0 [0]
252,0   32       11     2.989617129 13805  Q ZFS B 1048576 + 0 [blkzone]
252,0   32       12     2.989621317 13805  G ZFS B 1048576 + 0 [blkzone]
252,0   32       13     2.989623761 13805  I ZFS B 1048576 + 0 [blkzone]
252,0   32       14     2.989672713  1048  D ZFS B 1048576 + 0 [kworker/32:1H]
252,0   32       15     2.989694103   172  C ZFS B 1048576 + 0 [0]
252,0   32       16     2.989707098 13805  Q ZFS B 1572864 + 0 [blkzone]
252,0   32       17     2.989711766 13805  G ZFS B 1572864 + 0 [blkzone]
252,0   32       18     2.989714291 13805  I ZFS B 1572864 + 0 [blkzone]
252,0   32       19     2.989729750  1048  D ZFS B 1572864 + 0 [kworker/32:1H]
252,0   32       20     2.989743776   172  C ZFS B 1572864 + 0 [0]
252,0   33        1     2.998629410 13806  Q ZRAS I 0 + 0 [blkzone]
252,0   33        2     2.998653786 13806  G ZRAS I 0 + 0 [blkzone]
252,0   33        3     2.998656761 13806  I ZRAS I 0 + 0 [blkzone]
252,0   33        4     2.998683872  1049  D ZRAS I 0 + 0 [kworker/33:1H]
252,0   33        5     2.998718297   177  C ZRAS I 0 + 0 [0]
252,0   41        1     2.972191330 13803  Q ZOS B 0 + 0 [blkzone]
252,0   41        2     2.972200587 13803  G ZOS B 0 + 0 [blkzone]
252,0   41        3     2.972204354 13803  I ZOS B 0 + 0 [blkzone]
252,0   41        4     2.972241143  1034  D ZOS B 0 + 0 [kworker/41:1H]
252,0   41        5     2.972292119   217  C ZOS B 0 + 0 [0]
252,0   41        6     2.972314440 13803  Q ZOS B 524288 + 0 [blkzone]
252,0   41        7     2.972319239 13803  G ZOS B 524288 + 0 [blkzone]
252,0   41        8     2.972321995 13803  I ZOS B 524288 + 0 [blkzone]
252,0   41        9     2.972340369  1034  D ZOS B 524288 + 0 [kworker/41:1H]
252,0   41       10     2.972356519   217  C ZOS B 524288 + 0 [0]
252,0   41       11     2.972368031 13803  Q ZOS B 1048576 + 0 [blkzone]
252,0   41       12     2.972372509 13803  G ZOS B 1048576 + 0 [blkzone]
252,0   41       13     2.972375054 13803  I ZOS B 1048576 + 0 [blkzone]
252,0   41       14     2.972391455  1034  D ZOS B 1048576 + 0 [kworker/41:1H]
252,0   41       15     2.972406533   217  C ZOS B 1048576 + 0 [0]
252,0   41       16     2.972417504 13803  Q ZOS B 1572864 + 0 [blkzone]
252,0   41       17     2.972421702 13803  G ZOS B 1572864 + 0 [blkzone]
252,0   41       18     2.972424176 13803  I ZOS B 1572864 + 0 [blkzone]
252,0   41       19     2.972439094  1034  D ZOS B 1572864 + 0 [kworker/41:1H]
252,0   41       20     2.972453822   217  C ZOS B 1572864 + 0 [0]
252,0   25       11     3.008068992 13807  Q ZOS I 0 + 0 [blkzone]
252,0   25       12     3.008077979 13807  G ZOS I 0 + 0 [blkzone]
252,0   25       13     3.008081516 13807  I ZOS I 0 + 0 [blkzone]
252,0   25       14     3.008113265  1053  D ZOS I 0 + 0 [kworker/25:1H]
252,0   25       15     3.008135747   137  C ZOS I 0 + 0 [0]
252,0   25       16     3.008149694 13807  Q ZOS I 524288 + 0 [blkzone]
252,0   25       17     3.008154272 13807  G ZOS I 524288 + 0 [blkzone]
252,0   25       18     3.008156637 13807  I ZOS I 524288 + 0 [blkzone]
252,0   25       19     3.008172366  1053  D ZOS I 524288 + 0 [kworker/25:1H]
252,0   25       20     3.008186282   137  C ZOS I 524288 + 0 [0]
252,0   25       21     3.008196331 13807  Q ZOS I 1048576 + 0 [blkzone]
252,0   25       22     3.008200649 13807  G ZOS I 1048576 + 0 [blkzone]
252,0   25       23     3.008202843 13807  I ZOS I 1048576 + 0 [blkzone]
252,0   25       24     3.008217380  1053  D ZOS I 1048576 + 0 [kworker/25:1H]
252,0   25       25     3.008230856   137  C ZOS I 1048576 + 0 [0]
252,0   25       26     3.008240654 13807  Q ZOS I 1572864 + 0 [blkzone]
252,0   25       27     3.008244411 13807  G ZOS I 1572864 + 0 [blkzone]
252,0   25       28     3.008246645 13807  I ZOS I 1572864 + 0 [blkzone]
252,0   25       29     3.008260030  1053  D ZOS I 1572864 + 0 [kworker/25:1H]
252,0   25       30     3.008273245   137  C ZOS I 1572864 + 0 [0]
252,0   31        1     2.979885639 13804  Q ZCS B 0 + 0 [blkzone]
252,0   31        2     2.979898193 13804  G ZCS B 0 + 0 [blkzone]
252,0   31        3     2.979902080 13804  I ZCS B 0 + 0 [blkzone]
252,0   31        4     2.979934871  1052  D ZCS B 0 + 0 [kworker/31:1H]
252,0   31        5     2.979973514   167  C ZCS B 0 + 0 [0]
252,0   31        6     2.979987360 13804  Q ZCS B 524288 + 0 [blkzone]
252,0   31        7     2.979991037 13804  G ZCS B 524288 + 0 [blkzone]
252,0   31        8     2.979992850 13804  I ZCS B 524288 + 0 [blkzone]
252,0   31        9     2.980006295  1052  D ZCS B 524288 + 0 [kworker/31:1H]
252,0   31       10     2.980016935   167  C ZCS B 524288 + 0 [0]
252,0   31       11     2.980024209 13804  Q ZCS B 1048576 + 0 [blkzone]
252,0   31       12     2.980027475 13804  G ZCS B 1048576 + 0 [blkzone]
252,0   31       13     2.980029058 13804  I ZCS B 1048576 + 0 [blkzone]
252,0   31       14     2.980040680  1052  D ZCS B 1048576 + 0 [kworker/31:1H]
252,0   31       15     2.980050699   167  C ZCS B 1048576 + 0 [0]
252,0   31       16     2.980057802 13804  Q ZCS B 1572864 + 0 [blkzone]
252,0   31       17     2.980060537 13804  G ZCS B 1572864 + 0 [blkzone]
252,0   31       18     2.980062170 13804  I ZCS B 1572864 + 0 [blkzone]
252,0   31       19     2.980072970  1052  D ZCS B 1572864 + 0 [kworker/31:1H]
252,0   31       20     2.980082478   167  C ZCS B 1572864 + 0 [0]
252,0   35        1     3.018974043 13808  Q ZCS I 0 + 0 [blkzone]
252,0   35        2     3.018988300 13808  G ZCS I 0 + 0 [blkzone]
252,0   35        3     3.018992537 13808  I ZCS I 0 + 0 [blkzone]
252,0   35        4     3.019032963  1055  D ZCS I 0 + 0 [kworker/35:1H]
252,0   35        5     3.019078298   187  C ZCS I 0 + 0 [0]
252,0   35        6     3.019094759 13808  Q ZCS I 524288 + 0 [blkzone]
252,0   35        7     3.019099157 13808  G ZCS I 524288 + 0 [blkzone]
252,0   35        8     3.019101382 13808  I ZCS I 524288 + 0 [blkzone]
252,0   35        9     3.019118163  1055  D ZCS I 524288 + 0 [kworker/35:1H]
252,0   35       10     3.019131448   187  C ZCS I 524288 + 0 [0]
252,0   35       11     3.019140826 13808  Q ZCS I 1048576 + 0 [blkzone]
252,0   35       12     3.019144492 13808  G ZCS I 1048576 + 0 [blkzone]
252,0   35       13     3.019146526 13808  I ZCS I 1048576 + 0 [blkzone]
252,0   35       14     3.019161334  1055  D ZCS I 1048576 + 0 [kworker/35:1H]
252,0   35       15     3.019173817   187  C ZCS I 1048576 + 0 [0]
252,0   35       16     3.019182644 13808  Q ZCS I 1572864 + 0 [blkzone]
252,0   35       17     3.019186261 13808  G ZCS I 1572864 + 0 [blkzone]
252,0   35       18     3.019188295 13808  I ZCS I 1572864 + 0 [blkzone]
252,0   35       19     3.019201680  1055  D ZCS I 1572864 + 0 [kworker/35:1H]
252,0   35       20     3.019213822   187  C ZCS I 1572864 + 0 [0]
252,0   43        1     3.032206819 13809  Q ZFS I 0 + 0 [blkzone]
252,0   43        2     3.032215806 13809  G ZFS I 0 + 0 [blkzone]
252,0   43        3     3.032220595 13809  I ZFS I 0 + 0 [blkzone]
252,0   43        4     3.032342072   817  D ZFS I 0 + 0 [kworker/43:1H]
252,0   43        5     3.032383089   227  C ZFS I 0 + 0 [0]
252,0   43        6     3.032400502 13809  Q ZFS I 524288 + 0 [blkzone]
252,0   43        7     3.032407485 13809  G ZFS I 524288 + 0 [blkzone]
252,0   43        8     3.032410400 13809  I ZFS I 524288 + 0 [blkzone]
252,0   43        9     3.032428374   817  D ZFS I 524288 + 0 [kworker/43:1H]
252,0   43       10     3.032441409   227  C ZFS I 524288 + 0 [0]
252,0   43       11     3.032450766 13809  Q ZFS I 1048576 + 0 [blkzone]
252,0   43       12     3.032454894 13809  G ZFS I 1048576 + 0 [blkzone]
252,0   43       13     3.032457008 13809  I ZFS I 1048576 + 0 [blkzone]
252,0   43       14     3.032470884   817  D ZFS I 1048576 + 0 [kworker/43:1H]
252,0   43       15     3.032483157   227  C ZFS I 1048576 + 0 [0]
252,0   43       16     3.032492184 13809  Q ZFS I 1572864 + 0 [blkzone]
252,0   43       17     3.032495680 13809  G ZFS I 1572864 + 0 [blkzone]
252,0   43       18     3.032497704 13809  I ZFS I 1572864 + 0 [blkzone]
252,0   43       19     3.032510358   817  D ZFS I 1572864 + 0 [kworker/43:1H]
252,0   43       20     3.032522390   227  C ZFS I 1572864 + 0 [0]
CPU5 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        2,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU14 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU22 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU25 (252,0):
 Reads Queued:           6,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        6,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        6,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU26 (252,0):
 Reads Queued:          12,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       10,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       12,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU30 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU31 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU32 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU33 (252,0):
 Reads Queued:           1,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        1,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        1,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU35 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU39 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU41 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0
CPU43 (252,0):
 Reads Queued:           4,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:        4,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        4,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             3        	 Write depth:             0
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:          52,        0KiB	 Writes Queued:           0,        0KiB
 Read Dispatches:       52,        0KiB	 Write Dispatches:        0,        0KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:       52,        0KiB	 Writes Completed:        0,        0KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 260 entries
Skips: 0 forward (0 -   0.0%)

#######################################################################
* Basic tracepoint testing such as Queue, Get, Merge, Issue, Dispatch,
  Complete, Split,  with all the priority values masks.  Tracepoints
  with different Schedulers such as kyber, bfq, mq-deadline.
#######################################################################


####################     kyber     #####################
252,0    9        1     0.000000000  1112  Q  WS 0 + 8 [systemd-udevd]
252,0    9        2     0.000009698  1112  B  WS 0 + 8 [systemd-udevd]
252,0    9        3     0.000020047  1112  G  WS 0 + 8 [systemd-udevd]
252,0    9        4     0.000028543  1112  Q  WS 8 + 8 [systemd-udevd]
252,0    9        5     0.000033783  1112  B  WS 8 + 8 [systemd-udevd]
252,0    9        6     0.000036338  1112  M  WS 8 + 8 [systemd-udevd]
252,0    9        7     0.000043501  1112  Q  WS 16 + 8 [systemd-udevd]
252,0    9        8     0.000048621  1112  B  WS 16 + 8 [systemd-udevd]
252,0    9        9     0.000050094  1112  M  WS 16 + 8 [systemd-udevd]
252,0    9       10     0.000056776  1112  Q  WS 24 + 8 [systemd-udevd]
252,0    9       11     0.000061906  1112  B  WS 24 + 8 [systemd-udevd]
252,0    9       12     0.000063569  1112  M  WS 24 + 8 [systemd-udevd]
252,0    9       13     0.000075371  1112  Q  WS 32 + 8 [systemd-udevd]
252,0    9       14     0.000080781  1112  B  WS 32 + 8 [systemd-udevd]
252,0    9       15     0.000082244  1112  M  WS 32 + 8 [systemd-udevd]
252,0    9       16     0.000088295  1112  I  WS 0 + 40 [systemd-udevd]
252,0    9       17     0.000096090  1112  D  WS 0 + 40 [systemd-udevd]
252,0    9       18     0.000124183    57  C  WS 0 + 40 [0]
252,0    9       19     0.000129713    57  C  WS 0 + 8 [0]
252,0    9       20     0.000154960    57  C  WS 8 + 8 [0]
252,0    9       21     0.000160671    57  C  WS 16 + 8 [0]
252,0    9       22     0.000166121    57  C  WS 24 + 8 [0]
252,0    9       23     0.000171902    57  C  WS 32 + 8 [0]
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     bfq     #####################
252,0    9        1     0.000000000  1112  Q  WS 0 + 8 [systemd-udevd]
252,0    9        2     0.000011372  1112  B  WS 0 + 8 [systemd-udevd]
252,0    9        3     0.000033954  1112  G  WS 0 + 8 [systemd-udevd]
252,0    9        4     0.000043863  1112  Q  WS 8 + 8 [systemd-udevd]
252,0    9        5     0.000050104  1112  B  WS 8 + 8 [systemd-udevd]
252,0    9        6     0.000052679  1112  M  WS 8 + 8 [systemd-udevd]
252,0    9        7     0.000061185  1112  Q  WS 16 + 8 [systemd-udevd]
252,0    9        8     0.000067327  1112  B  WS 16 + 8 [systemd-udevd]
252,0    9        9     0.000069040  1112  M  WS 16 + 8 [systemd-udevd]
252,0    9       10     0.000076995  1112  Q  WS 24 + 8 [systemd-udevd]
252,0    9       11     0.000082715  1112  B  WS 24 + 8 [systemd-udevd]
252,0    9       12     0.000084389  1112  M  WS 24 + 8 [systemd-udevd]
252,0    9       13     0.000092183  1112  Q  WS 32 + 8 [systemd-udevd]
252,0    9       14     0.000097814  1112  B  WS 32 + 8 [systemd-udevd]
252,0    9       15     0.000099517  1112  M  WS 32 + 8 [systemd-udevd]
252,0    9       16     0.000107802  1112  I  WS 0 + 40 [systemd-udevd]
252,0    9       17     0.000150322  1112  D  WS 0 + 40 [systemd-udevd]
252,0    9       18     0.000190908    57  C  WS 0 + 40 [0]
252,0    9       19     0.000197090    57  C  WS 0 + 8 [0]
252,0    9       20     0.000228940    57  C  WS 8 + 8 [0]
252,0    9       21     0.000235772    57  C  WS 16 + 8 [0]
252,0    9       22     0.000242054    57  C  WS 24 + 8 [0]
252,0    9       23     0.000248757    57  C  WS 32 + 8 [0]
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     mq-deadline     #####################
252,0    9        1     0.000000000  1112  Q  WS 0 + 8 [systemd-udevd]
252,0    9        2     0.000012473  1112  B  WS 0 + 8 [systemd-udevd]
252,0    9        3     0.000024967  1112  G  WS 0 + 8 [systemd-udevd]
252,0    9        4     0.000035166  1112  Q  WS 8 + 8 [systemd-udevd]
252,0    9        5     0.000041307  1112  B  WS 8 + 8 [systemd-udevd]
252,0    9        6     0.000043922  1112  M  WS 8 + 8 [systemd-udevd]
252,0    9        7     0.000051937  1112  Q  WS 16 + 8 [systemd-udevd]
252,0    9        8     0.000057718  1112  B  WS 16 + 8 [systemd-udevd]
252,0    9        9     0.000059331  1112  M  WS 16 + 8 [systemd-udevd]
252,0    9       10     0.000066695  1112  Q  WS 24 + 8 [systemd-udevd]
252,0    9       11     0.000072055  1112  B  WS 24 + 8 [systemd-udevd]
252,0    9       12     0.000073678  1112  M  WS 24 + 8 [systemd-udevd]
252,0    9       13     0.000081252  1112  Q  WS 32 + 8 [systemd-udevd]
252,0    9       14     0.000086813  1112  B  WS 32 + 8 [systemd-udevd]
252,0    9       15     0.000088406  1112  M  WS 32 + 8 [systemd-udevd]
252,0    9       16     0.000095749  1112  I  WS 0 + 40 [systemd-udevd]
252,0    9       17     0.000104366  1112  D  WS 0 + 40 [systemd-udevd]
252,0    9       18     0.000136416    57  C  WS 0 + 40 [0]
252,0    9       19     0.000142627    57  C  WS 0 + 8 [0]
252,0    9       20     0.000174527    57  C  WS 8 + 8 [0]
252,0    9       21     0.000181340    57  C  WS 16 + 8 [0]
252,0    9       22     0.000187371    57  C  WS 24 + 8 [0]
252,0    9       23     0.000193433    57  C  WS 32 + 8 [0]
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     none     #####################
252,0    9        1     0.000000000  1112  Q  WS 0 + 8 [systemd-udevd]
252,0    9        2     0.000011352  1112  B  WS 0 + 8 [systemd-udevd]
252,0    9        3     0.000017914  1112  G  WS 0 + 8 [systemd-udevd]
252,0    9        4     0.000027522  1112  Q  WS 8 + 8 [systemd-udevd]
252,0    9        5     0.000033613  1112  B  WS 8 + 8 [systemd-udevd]
252,0    9        6     0.000036679  1112  M  WS 8 + 8 [systemd-udevd]
252,0    9        7     0.000045345  1112  Q  WS 16 + 8 [systemd-udevd]
252,0    9        8     0.000050896  1112  B  WS 16 + 8 [systemd-udevd]
252,0    9        9     0.000052599  1112  M  WS 16 + 8 [systemd-udevd]
252,0    9       10     0.000060654  1112  Q  WS 24 + 8 [systemd-udevd]
252,0    9       11     0.000066064  1112  B  WS 24 + 8 [systemd-udevd]
252,0    9       12     0.000067747  1112  M  WS 24 + 8 [systemd-udevd]
252,0    9       13     0.000075482  1112  Q  WS 32 + 8 [systemd-udevd]
252,0    9       14     0.000081673  1112  B  WS 32 + 8 [systemd-udevd]
252,0    9       15     0.000083397  1112  M  WS 32 + 8 [systemd-udevd]
252,0    9       16     0.000090460  1112  D  WS 0 + 40 [systemd-udevd]
252,0    9       17     0.000125486    57  C  WS 0 + 40 [0]
252,0    9       18     0.000131757    57  C  WS 0 + 8 [0]
252,0    9       19     0.000162685    57  C  WS 8 + 8 [0]
252,0    9       20     0.000169568    57  C  WS 16 + 8 [0]
252,0    9       21     0.000176221    57  C  WS 24 + 8 [0]
252,0    9       22     0.000182553    57  C  WS 32 + 8 [0]
CPU9 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 22 entries
Skips: 0 forward (0 -   0.0%)
####################     split     #####################
252,0   26        1     0.000000000 16932  Q  DS 0 + 80 [blkdiscard]
252,0   26        2     0.000006162 16932  X  DS 0 / 0 [blkdiscard]
252,0   26        3     0.000015980 16932  G  DS 0 + 4 [blkdiscard]
252,0   26        4     0.000020438 16932  X  DS 4 / 0 [blkdiscard]
252,0   26        5     0.000023855 16932  G  DS 4 + 4 [blkdiscard]
252,0   26        6     0.000026790 16932  X  DS 8 / 0 [blkdiscard]
252,0   26        7     0.000029856 16932  G  DS 8 + 4 [blkdiscard]
252,0   26        8     0.000032721 16932  X  DS 12 / 0 [blkdiscard]
252,0   26        9     0.000035737 16932  G  DS 12 + 4 [blkdiscard]
252,0   26       10     0.000038582 16932  X  DS 16 / 0 [blkdiscard]
252,0   26       11     0.000047169 16932  I  DS 0 + 4 [blkdiscard]
252,0   26       12     0.000049262 16932  I  DS 4 + 4 [blkdiscard]
252,0   26       13     0.000050986 16932  I  DS 8 + 4 [blkdiscard]
252,0   26       14     0.000052639 16932  I  DS 12 + 4 [blkdiscard]
252,0   26       15     0.000105678   830  D  DS 0 + 4 [kworker/26:1H]
252,0   26       16     0.000117080   830  D  DS 4 + 4 [kworker/26:1H]
252,0   26       17     0.000119955   830  D  DS 8 + 4 [kworker/26:1H]
252,0   26       18     0.000122530   830  D  DS 12 + 4 [kworker/26:1H]
252,0   26       19     0.000136376   142  C  DS 0 + 4 [0]
252,0   26       20     0.000143780   142  C  DS 0 + 8 [0]
252,0   26       21     0.000158367   142  C  DS 0 + 12 [0]
252,0   26       22     0.000161804   142  C  DS 0 + 16 [0]
252,0   26       23     0.000171722 16932  G  DS 16 + 4 [blkdiscard]
252,0   26       24     0.000176160 16932  X  DS 20 / 0 [blkdiscard]
252,0   26       25     0.000179647 16932  G  DS 20 + 4 [blkdiscard]
252,0   26       26     0.000182542 16932  X  DS 24 / 0 [blkdiscard]
252,0   26       27     0.000185588 16932  G  DS 24 + 4 [blkdiscard]
252,0   26       28     0.000188443 16932  X  DS 28 / 0 [blkdiscard]
252,0   26       29     0.000191449 16932  G  DS 28 + 4 [blkdiscard]
252,0   26       30     0.000194194 16932  X  DS 32 / 0 [blkdiscard]
252,0   26       31     0.000199384 16932  I  DS 16 + 4 [blkdiscard]
252,0   26       32     0.000201087 16932  I  DS 20 + 4 [blkdiscard]
252,0   26       33     0.000202620 16932  I  DS 24 + 4 [blkdiscard]
252,0   26       34     0.000204153 16932  I  DS 28 + 4 [blkdiscard]
252,0   26       35     0.000223189   830  D  DS 16 + 4 [kworker/26:1H]
252,0   26       36     0.000231154   830  D  DS 20 + 4 [kworker/26:1H]
252,0   26       37     0.000233779   830  D  DS 24 + 4 [kworker/26:1H]
252,0   26       38     0.000236223   830  D  DS 28 + 4 [kworker/26:1H]
252,0   26       39     0.000244449   142  C  DS 0 + 20 [0]
252,0   26       40     0.000248326   142  C  DS 0 + 24 [0]
252,0   26       41     0.000259377   142  C  DS 0 + 28 [0]
252,0   26       42     0.000262673   142  C  DS 0 + 32 [0]
252,0   26       43     0.000271269 16932  G  DS 32 + 4 [blkdiscard]
252,0   26       44     0.000275176 16932  X  DS 36 / 0 [blkdiscard]
252,0   26       45     0.000278382 16932  G  DS 36 + 4 [blkdiscard]
252,0   26       46     0.000281197 16932  X  DS 40 / 0 [blkdiscard]
252,0   26       47     0.000284203 16932  G  DS 40 + 4 [blkdiscard]
252,0   26       48     0.000286998 16932  X  DS 44 / 0 [blkdiscard]
252,0   26       49     0.000290024 16932  G  DS 44 + 4 [blkdiscard]
252,0   26       50     0.000292829 16932  X  DS 48 / 0 [blkdiscard]
252,0   26       51     0.000297748 16932  I  DS 32 + 4 [blkdiscard]
252,0   26       52     0.000299412 16932  I  DS 36 + 4 [blkdiscard]
252,0   26       53     0.000300965 16932  I  DS 40 + 4 [blkdiscard]
252,0   26       54     0.000302527 16932  I  DS 44 + 4 [blkdiscard]
252,0   26       55     0.000319810   830  D  DS 32 + 4 [kworker/26:1H]
252,0   26       56     0.000327324   830  D  DS 36 + 4 [kworker/26:1H]
252,0   26       57     0.000329899   830  D  DS 40 + 4 [kworker/26:1H]
252,0   26       58     0.000332343   830  D  DS 44 + 4 [kworker/26:1H]
252,0   26       59     0.000340138   142  C  DS 0 + 36 [0]
252,0   26       60     0.000343805   142  C  DS 0 + 40 [0]
252,0   26       61     0.000354515   142  C  DS 0 + 44 [0]
252,0   26       62     0.000357721   142  C  DS 0 + 48 [0]
252,0   26       63     0.000366227 16932  G  DS 48 + 4 [blkdiscard]
252,0   26       64     0.000370054 16932  X  DS 52 / 0 [blkdiscard]
252,0   26       65     0.000373200 16932  G  DS 52 + 4 [blkdiscard]
252,0   26       66     0.000376045 16932  X  DS 56 / 0 [blkdiscard]
252,0   26       67     0.000379011 16932  G  DS 56 + 4 [blkdiscard]
252,0   26       68     0.000381816 16932  X  DS 60 / 0 [blkdiscard]
252,0   26       69     0.000384752 16932  G  DS 60 + 4 [blkdiscard]
252,0   26       70     0.000387547 16932  X  DS 64 / 0 [blkdiscard]
252,0   26       71     0.000392376 16932  I  DS 48 + 4 [blkdiscard]
252,0   26       72     0.000393999 16932  I  DS 52 + 4 [blkdiscard]
252,0   26       73     0.000395552 16932  I  DS 56 + 4 [blkdiscard]
252,0   26       74     0.000397105 16932  I  DS 60 + 4 [blkdiscard]
252,0   26       75     0.000414037   830  D  DS 48 + 4 [kworker/26:1H]
252,0   26       76     0.000421290   830  D  DS 52 + 4 [kworker/26:1H]
252,0   26       77     0.000423765   830  D  DS 56 + 4 [kworker/26:1H]
252,0   26       78     0.000426179   830  D  DS 60 + 4 [kworker/26:1H]
252,0   26       79     0.000434014   142  C  DS 0 + 52 [0]
252,0   26       80     0.000437741   142  C  DS 0 + 56 [0]
252,0   26       81     0.000448231   142  C  DS 0 + 60 [0]
252,0   26       82     0.000451487   142  C  DS 0 + 64 [0]
252,0   26       83     0.000459903 16932  G  DS 64 + 4 [blkdiscard]
252,0   26       84     0.000463630 16932  X  DS 68 / 0 [blkdiscard]
252,0   26       85     0.000466846 16932  G  DS 68 + 4 [blkdiscard]
252,0   26       86     0.000469781 16932  X  DS 72 / 0 [blkdiscard]
252,0   26       87     0.000472767 16932  G  DS 72 + 4 [blkdiscard]
252,0   26       88     0.000476864 16932  G  DS 76 + 4 [blkdiscard]
252,0   26       89     0.000481543 16932  I  DS 64 + 4 [blkdiscard]
252,0   26       90     0.000483156 16932  I  DS 68 + 4 [blkdiscard]
252,0   26       91     0.000484699 16932  I  DS 72 + 4 [blkdiscard]
252,0   26       92     0.000486282 16932  I  DS 76 + 4 [blkdiscard]
252,0   26       93     0.000504757   830  D  DS 64 + 4 [kworker/26:1H]
252,0   26       94     0.000512191   830  D  DS 68 + 4 [kworker/26:1H]
252,0   26       95     0.000514665   830  D  DS 72 + 4 [kworker/26:1H]
252,0   26       96     0.000517080   830  D  DS 76 + 4 [kworker/26:1H]
252,0   26       97     0.000525435   142  C  DS 0 + 68 [0]
252,0   26       98     0.000529102   142  C  DS 0 + 72 [0]
252,0   26       99     0.000532248   142  C  DS 0 + 76 [0]
252,0   26      100     0.000535354   142  C  DS 0 + 80 [0]
CPU26 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           1,       40KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       20,       40KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:       20,      420KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             0        	 Write depth:             4
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 100 entries
Skips: 0 forward (0 -   0.0%)
####################     requeue     #####################
252,0   18        1     0.000000000 17011  Q  WS 0 + 8 [dd]
252,0   18        2     0.000011441 17011  G  WS 0 + 8 [dd]
252,0   18        3     0.000018434 17011  I  WS 0 + 8 [dd]
252,0   18        4     0.000055574  1007  D  WS 0 + 8 [kworker/18:1H]
252,0   18        5     0.000077355   102  C  WS 0 + 8 [0]
252,0   18        6     0.000122239 17011  Q  WS 8 + 8 [dd]
252,0   18        7     0.000126517 17011  G  WS 8 + 8 [dd]
252,0   18        8     0.000130795 17011  I  WS 8 + 8 [dd]
252,0   18        9     0.000149209  1007  D  WS 8 + 8 [kworker/18:1H]
252,0   18       10     0.000163065   102  C  WS 8 + 8 [0]
252,0   18       11     0.000197510 17011  Q  WS 16 + 8 [dd]
252,0   18       12     0.000201658 17011  G  WS 16 + 8 [dd]
252,0   18       13     0.000205615 17011  I  WS 16 + 8 [dd]
252,0   18       14     0.000223398  1007  D  WS 16 + 8 [kworker/18:1H]
252,0   18       15     0.000226775  1007  R  WS 16 + 8 [0]
252,0   18       16     0.000236303  1007  D  WS 16 + 8 [kworker/18:1H]
252,0   18       17     0.000239048  1007  R  WS 16 + 8 [0]
252,0   18       18     0.000367328  1007  I  WS 16 + 8 [kworker/18:1H]
252,0   18       19     0.000374081  1007  D  WS 16 + 8 [kworker/18:1H]
252,0   18       20     0.000388739   102  C  WS 16 + 8 [0]
252,0   18       21     0.000422562 17011  Q  WS 24 + 8 [dd]
252,0   18       22     0.000426549 17011  G  WS 24 + 8 [dd]
252,0   18       23     0.000430266 17011  I  WS 24 + 8 [dd]
252,0   18       24     0.000446116  1007  D  WS 24 + 8 [kworker/18:1H]
252,0   18       25     0.000482334   102  C  WS 24 + 8 [0]
252,0   18       26     0.000534241 17011  Q  WS 32 + 8 [dd]
252,0   18       27     0.000538610 17011  G  WS 32 + 8 [dd]
252,0   18       28     0.000542647 17011  I  WS 32 + 8 [dd]
252,0   18       29     0.000559789  1007  D  WS 32 + 8 [kworker/18:1H]
252,0   18       30     0.000562865  1007  R  WS 32 + 8 [0]
252,0   18       31     0.000570529  1007  D  WS 32 + 8 [kworker/18:1H]
252,0   18       32     0.000572894  1007  R  WS 32 + 8 [0]
252,0   18       33     0.000580689  1007  I  WS 32 + 8 [kworker/18:1H]
252,0   18       34     0.000584345  1007  D  WS 32 + 8 [kworker/18:1H]
252,0   18       35     0.000597420   102  C  WS 32 + 8 [0]
252,0   18       36     0.000628739 17011  Q  WS 40 + 8 [dd]
252,0   18       37     0.000632526 17011  G  WS 40 + 8 [dd]
252,0   18       38     0.000636082 17011  I  WS 40 + 8 [dd]
252,0   18       39     0.000652413  1007  D  WS 40 + 8 [kworker/18:1H]
252,0   18       40     0.000663975   102  C  WS 40 + 8 [0]
252,0   18       41     0.000693049 17011  Q  WS 48 + 8 [dd]
252,0   18       42     0.000696696 17011  G  WS 48 + 8 [dd]
252,0   18       43     0.000700183 17011  I  WS 48 + 8 [dd]
252,0   18       44     0.000715161  1007  D  WS 48 + 8 [kworker/18:1H]
252,0   18       45     0.000717756  1007  R  WS 48 + 8 [0]
252,0   18       46     0.000725079  1007  D  WS 48 + 8 [kworker/18:1H]
252,0   18       47     0.000727404  1007  R  WS 48 + 8 [0]
252,0   18       48     0.000734908  1007  I  WS 48 + 8 [kworker/18:1H]
252,0   18       49     0.000738304  1007  D  WS 48 + 8 [kworker/18:1H]
252,0   18       50     0.000740679  1007  R  WS 48 + 8 [0]
252,0   18       51     0.005506246  1007  D  WS 48 + 8 [kworker/18:1H]
252,0   18       52     0.005516635   102  C  WS 48 + 8 [0]
252,0   18       53     0.005548114 17011  Q  WS 56 + 8 [dd]
252,0   18       54     0.005551881 17011  G  WS 56 + 8 [dd]
252,0   18       55     0.005555207 17011  I  WS 56 + 8 [dd]
252,0   18       56     0.005568663  1007  D  WS 56 + 8 [kworker/18:1H]
252,0   18       57     0.005577930   102  C  WS 56 + 8 [0]
252,0   18       58     0.005601174 17011  Q  WS 64 + 8 [dd]
252,0   18       59     0.005604129 17011  G  WS 64 + 8 [dd]
252,0   18       60     0.005606914 17011  I  WS 64 + 8 [dd]
252,0   18       61     0.005618656  1007  D  WS 64 + 8 [kworker/18:1H]
252,0   18       62     0.005627743   102  C  WS 64 + 8 [0]
252,0   18       63     0.005650296 17011  Q  WS 72 + 8 [dd]
252,0   18       64     0.005653221 17011  G  WS 72 + 8 [dd]
252,0   18       65     0.005655936 17011  I  WS 72 + 8 [dd]
252,0   18       66     0.005667468  1007  D  WS 72 + 8 [kworker/18:1H]
252,0   18       67     0.005676495   102  C  WS 72 + 8 [0]
CPU18 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:          10,       40KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       17,       40KiB
 Reads Requeued:         0		 Writes Requeued:         7
 Reads Completed:        0,        0KiB	 Writes Completed:       10,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 8,000KiB/s
Events (252,0): 67 entries
Skips: 0 forward (0 -   0.0%)
####################     cgroup     #####################
252,0   16        1     0.000000000 17090  Q  WS 0 + 8 [dd]
252,0   16        2     0.000010790 17090  G  WS 0 + 8 [dd]
252,0   16        3     0.000020839 17090  I  WS 0 + 8 [dd]
252,0   16        4     0.000056636  1728  D  WS 0 + 8 [kworker/16:1H]
252,0   16        5     0.000076984    92  C  WS 0 + 8 [0]
252,0   16        6     0.000110487 17090  Q  WS 8 + 8 [dd]
252,0   16        7     0.000114444 17090  G  WS 8 + 8 [dd]
252,0   16        8     0.000118322 17090  I  WS 8 + 8 [dd]
252,0   16        9     0.000135093  1728  D  WS 8 + 8 [kworker/16:1H]
252,0   16       10     0.000147436    92  C  WS 8 + 8 [0]
252,0   16       11     0.000172223 17090  Q  WS 16 + 8 [dd]
252,0   16       12     0.000175900 17090  G  WS 16 + 8 [dd]
252,0   16       13     0.000179506 17090  I  WS 16 + 8 [dd]
252,0   16       14     0.000195136  1728  D  WS 16 + 8 [kworker/16:1H]
252,0   16       15     0.000206868    92  C  WS 16 + 8 [0]
252,0   16       16     0.000231043 17090  Q  WS 24 + 8 [dd]
252,0   16       17     0.000234680 17090  G  WS 24 + 8 [dd]
252,0   16       18     0.000238266 17090  I  WS 24 + 8 [dd]
252,0   16       19     0.000253345  1728  D  WS 24 + 8 [kworker/16:1H]
252,0   16       20     0.000264816    92  C  WS 24 + 8 [0]
252,0   16       21     0.000288340 17090  Q  WS 32 + 8 [dd]
252,0   16       22     0.000291997 17090  G  WS 32 + 8 [dd]
252,0   16       23     0.000295584 17090  I  WS 32 + 8 [dd]
252,0   16       24     0.000310502  1728  D  WS 32 + 8 [kworker/16:1H]
252,0   16       25     0.000321733    92  C  WS 32 + 8 [0]
252,0   16       26     0.023759266   335  Q  WS 40 + 8 [kworker/16:1]
252,0   16       27     0.023765247   335  G  WS 40 + 8 [kworker/16:1]
252,0   16       28     0.023769776   335  I  WS 40 + 8 [kworker/16:1]
252,0   16       29     0.023774865   335  D  WS 40 + 8 [kworker/16:1]
252,0   16       30     0.023788792    92  C  WS 40 + 8 [0]
252,0   16       31     0.023821062 17090  Q  WS 48 + 8 [dd]
252,0   16       32     0.023824338 17090  G  WS 48 + 8 [dd]
252,0   16       33     0.023827634 17090  I  WS 48 + 8 [dd]
252,0   16       34     0.023843574  1728  D  WS 48 + 8 [kworker/16:1H]
252,0   16       35     0.023853393    92  C  WS 48 + 8 [0]
252,0   16       36     0.023873190 17090  Q  WS 56 + 8 [dd]
252,0   16       37     0.023876165 17090  G  WS 56 + 8 [dd]
252,0   16       38     0.023879041 17090  I  WS 56 + 8 [dd]
252,0   16       39     0.023891314  1728  D  WS 56 + 8 [kworker/16:1H]
252,0   16       40     0.023900331    92  C  WS 56 + 8 [0]
252,0   16       41     0.023918845 17090  Q  WS 64 + 8 [dd]
252,0   16       42     0.023921801 17090  G  WS 64 + 8 [dd]
252,0   16       43     0.023924636 17090  I  WS 64 + 8 [dd]
252,0   16       44     0.023936278  1728  D  WS 64 + 8 [kworker/16:1H]
252,0   16       45     0.023945275    92  C  WS 64 + 8 [0]
252,0   16       46     0.023963439 17090  Q  WS 72 + 8 [dd]
252,0   16       47     0.023966335 17090  G  WS 72 + 8 [dd]
252,0   16       48     0.023969080 17090  I  WS 72 + 8 [dd]
252,0   16       49     0.023980691  1728  D  WS 72 + 8 [kworker/16:1H]
252,0   16       50     0.023989568    92  C  WS 72 + 8 [0]
252,0   38        1     0.038172766  1112  Q  WS 0 + 8 [systemd-udevd]
252,0   38        2     0.038180330  1112  G  WS 0 + 8 [systemd-udevd]
252,0   38        3     0.038187564  1112  Q  WS 8 + 8 [systemd-udevd]
252,0   38        4     0.038190259  1112  M  WS 8 + 8 [systemd-udevd]
252,0   38        5     0.038196711  1112  Q  WS 16 + 8 [systemd-udevd]
252,0   38        6     0.038198695  1112  M  WS 16 + 8 [systemd-udevd]
252,0   38        7     0.038204676  1112  Q  WS 24 + 8 [systemd-udevd]
252,0   38        8     0.038206650  1112  M  WS 24 + 8 [systemd-udevd]
252,0   38        9     0.038212471  1112  Q  WS 32 + 8 [systemd-udevd]
252,0   38       10     0.038214414  1112  M  WS 32 + 8 [systemd-udevd]
252,0   38       11     0.038220125  1112  Q  WS 40 + 8 [systemd-udevd]
252,0   38       12     0.038222029  1112  M  WS 40 + 8 [systemd-udevd]
252,0   38       13     0.038227709  1112  Q  WS 48 + 8 [systemd-udevd]
252,0   38       14     0.038229613  1112  M  WS 48 + 8 [systemd-udevd]
252,0   38       15     0.038235344  1112  Q  WS 56 + 8 [systemd-udevd]
252,0   38       16     0.038237217  1112  M  WS 56 + 8 [systemd-udevd]
252,0   38       17     0.038242898  1112  Q  WS 64 + 8 [systemd-udevd]
252,0   38       18     0.038244781  1112  M  WS 64 + 8 [systemd-udevd]
252,0   38       19     0.038250602  1112  Q  WS 72 + 8 [systemd-udevd]
252,0   38       20     0.038252506  1112  M  WS 72 + 8 [systemd-udevd]
252,0   38       21     0.038257585  1112  I  WS 0 + 80 [systemd-udevd]
252,0   38       22     0.038262194  1112  D  WS 0 + 80 [systemd-udevd]
252,0   38       23     0.038283815   202  C  WS 0 + 80 [0]
CPU16 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:          10,       40KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       10,       40KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:       10,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            0,        0KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0
CPU38 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:          10,       40KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       40KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        1,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            9,       36KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Total (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:          20,       80KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:       11,       80KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:       11,       80KiB
 Read Merges:            0,        0KiB	 Write Merges:            9,       36KiB
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 2,105KiB/s
Events (252,0): 73 entries
Skips: 0 forward (0 -   0.0%)

-- 
2.22.1

