Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3500B1F6EC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgFKUbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 16:31:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39499 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbgFKUbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 16:31:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1075B5C01CC;
        Thu, 11 Jun 2020 16:31:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 11 Jun 2020 16:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GOb4NQNkLZnjs/XE2YK9IvfIf62
        TLz/Apu3KDBpvn0Q=; b=YdRcvpR6giCvqgPb612UxoF3q4etbQq1okfBBI2qVUi
        LWKxxg8DH980kzCBQcrD0qKil8uVPe/vE6HFV47KvKw+ZyvVwOAuqU4Pg8+9DrVw
        rXebKcaXxNt2ilAaiUJJZKcp3ntArWgU8AtErIwuXFrD+jVG+QLb8n3zqGnFMYPX
        fcrl4sUswxtgzpid28nXHF8j+O3gR6yfxQhAFf0omYC9ZAWQbUG7REwaBSLVeyb+
        MmzzgOEerl7iz7EKMbMvkNX4IkwjQPB/nhHblYYQHyyu9w0SgqCre6Lg5eYTwQ5H
        auhzLcUOoamHnck2srRHU6jtqzKeKWQMRZw+G79w+rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GOb4NQ
        NkLZnjs/XE2YK9IvfIf62TLz/Apu3KDBpvn0Q=; b=MmvqkgaZBTpneaYJSo/2PX
        uUQm8W7bYGxHCcx4AadO0m0jJQTmecb3RL8STOOWix+B35/+CcmI8xORN03G8Lqu
        fNlRmByxfQZ2tu1Hl2uncur9DHEQsmsJ2/zVC351QMKUVTm6bELJH4TrF+4XL0Gq
        nEvy45gEy6P9mwoL7CJRWXOTvG08sMNjORKSY/tHVkMzskG8VCs/M1HDcOy1oKwM
        c9xzKS2WUq3pkcezOEfVyBjRgyPAW+/KSxy+Lg2lxP+v4wDmIAab8Oke0ZZtjMyL
        vZQ9FtBm6McuFGwSI6yYuRdtoSt9NxsbabgbAC22+00bXpTCK2S8pmTuvxj1+yig
        ==
X-ME-Sender: <xms:gZTiXpO7PhRp469Qqe1pijyw7O_V6CCIuVaXfcjH08PmxZ1qUdO4pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehmtd
    erredttddvnecuhfhrohhmpeetnhgurhgvshcuhfhrvghunhguuceorghnughrvghssegr
    nhgrrhgriigvlhdruggvqeenucggtffrrghtthgvrhhnpefhueejteevueehjedufedvhe
    fftedvueeukeefvdelteehffdufeffhfeluedvffenucffohhmrghinhepphhoshhtghhr
    rdgvshenucfkphepudejvddrheekrdelhedrjedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:gpTiXr8LtqgVyLeG8EFJNBLrBRjSoIhBO7SSNIASTnZe_T13PO01yA>
    <xmx:gpTiXoTyhNFRSp1kxp5GMjLaUiP29q9yC6ghPxIsfq-G1zd0KYmvqw>
    <xmx:gpTiXltGEfYMJwN5r9ZO8HrgAQ2MQmvSkrd1FHuz4x29C3dFkUzvIg>
    <xmx:hpTiXnpXIpSbSObbA_nPRdCkkOoHB6z8ueqa_OkNxqyC-tIgHXS2Aw>
Received: from intern.anarazel.de (unknown [172.58.95.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 67AEA328006B;
        Thu, 11 Jun 2020 16:30:57 -0400 (EDT)
Date:   Thu, 11 Jun 2020 13:30:52 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] page cache drop-behind
Message-ID: <20200611203052.5u44uragywisp6zt@alap3.anarazel.de>
References: <20200610023939.GI19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3zpccx366epa2vi"
Content-Disposition: inline
In-Reply-To: <20200610023939.GI19604@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--u3zpccx366epa2vi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

That's great!


On 2020-06-09 19:39:39 -0700, Matthew Wilcox wrote:
> Andres reported a problem recently where reading a file several times
> the size of memory causes intermittent stalls.  My suspicion is that
> page allocation eventually runs into the low watermark and starts to
> do reclaim.  Some shrinkers take a long time to run and have a low chance
> of actually freeing a page (eg the dentry cache needs to free 21 dentries
> which all happen to be on the same pair of pages to free those two pages).

That meshes with some of what I saw in profiles, IIRC.

There's a related issue that I don't think this would solve, but which
could be solved by some form of write-behind, in particular that I've
observed that reaching dirty data limits often leads to a pretty random
selection of pages being written back.


> This patch attempts to free pages from the file that we're currently
> reading from if there are no pages readily available.  If that doesn't
> work, we'll run all the shrinkers just as we did before.

> This should solve Andres' problem, although it's a bit narrow in scope.
> It might be better to look through the inactive page list, regardless of
> which file they were allocated for.  That could solve the "weekly backup"
> problem with lots of little files.

I wonder if there are cases where that'd cause problems:
1) If the pages selected are still dirty, doesn't this have a
   significant potential for additional stalls?
2) For some database/postgres tasks it's pretty common to occasionally
   do in-place writes where parts of the data is already in the page
   cache, but others aren't. A bit worried that this'd be more aggre
   aggressive throwing away pages that were already cached before the
   writes.


> I'm not really set up to do performance testing at the moment, so this
> is just me thinking hard about the problem.

The workload where I was observing the issue was creating backups of
larger postgres databases. I've attached the test program we've used.

gcc -Wall -ggdb ~/tmp/write_and_fsync.c -o /tmp/write_and_fsync && \
  rm -f /srv/dev/bench/test* && \
  echo 3 |sudo tee /proc/sys/vm/drop_caches && \
  perf stat -a -e cpu-clock,ref-cycles,cycles,instructions \
     /tmp/write_and_fsync --blocksize $((128*1024)) --sync_file_range=0 --fallocate=0 --fadvise=0 --sequential=0 --filesize=$((100*1024*1024*1024)) /srv/dev/bench/test{1,2,3,4}

Was the last invocation I found in my shell history :)

I found that sync_file_range=1, fadvise=1 often gave considerably better
performance. Here's a pointer to the thread with more details (see also
my response downthread):
https://postgr.es/m/20200503023643.x2o2244sa4vkikyb%40alap3.anarazel.de

Greetings,

Andres Freund

--u3zpccx366epa2vi
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="write_and_fsync.c"

#define _GNU_SOURCE

#include <fcntl.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
#include <stdbool.h>

#define SFR_START_WRITE_DELAY (1 * 1024 * 1024)
#define SFR_WAIT_WRITE_DELAY (8 * 1024 * 1024)
#define SFR_START_SIZE (512 * 1024)
#define SFR_WAIT_SIZE (8 * 1024 * 1024)

#define FADVISE_DONTNEED_SIZE (512 * 1024)
#define FADVISE_DONTNEED_DELAY (SFR_WAIT_WRITE_DELAY + FADVISE_DONTNEED_SIZE)

typedef struct runparams
{
	uint32_t blocksize;
	uint64_t filesize;
	int numprocs;
	int numfiles;
	char **filenames;
	bool fallocate;
	bool fadvise;
	bool sync_file_range;
	bool sequential;
} runparams;

extern void runtest(const runparams *params, char *filename);

const struct option getopt_options[] = {
	{.name = "filesize", .has_arg = required_argument,  .val = 's'},
	{.name = "blocksize", .has_arg = required_argument, .val = 'b'},
	{.name = "fallocate", .has_arg = required_argument, .val = 'a'},
	{.name = "fadvise", .has_arg = required_argument, .val = 'f'},
	{.name = "sync_file_range",  .has_arg = required_argument, .val = 'r'},
	{.name = "sequential",  .has_arg = required_argument, .val = 'q'},
	{}};

static void
helpdie(void)
{
	fprintf(stderr, "\n"
			"Usage: write_and_fsync [OPTIONS] [FILES]\n"
			"--filesize=...\n"
			"--blocksize=...\n"
			"--fallocate=yes/no/0/1\n"
			"--fadvise=yes/no/0/1\n"
			"--sync_file_range=yes/no/0/1\n"
			"--sequential=yes/no/0/1\n");
	exit(1);
}

int
main(int argc, char **argv)
{
	runparams params = {
		.blocksize = 8192,
	};
	int	status;

	while (1)
	{
		int o;

		o = getopt_long(argc, argv, "", getopt_options, NULL);

		if (o == -1)
			break;

		switch (o)
		{
			case 0:
				break;
			case 's':
				params.filesize = strtoull(optarg, NULL, 0);
				break;
			case 'b':
				params.blocksize = strtoul(optarg, NULL, 0);
				break;
			case 'a':
				params.fallocate = strcmp(optarg, "yes") == 0 || strcmp(optarg, "1") == 0;
				break;
			case 'f':
				params.fadvise = strcmp(optarg, "yes") == 0 || strcmp(optarg, "1") == 0;
				break;
			case 'r':
				params.sync_file_range = strcmp(optarg, "yes") == 0 || strcmp(optarg, "1") == 0;
				break;
			case 'q':
				params.sequential = strcmp(optarg, "yes") == 0 || strcmp(optarg, "1") == 0;
				break;
			case '?':
				helpdie();
				break;
			default:
				fprintf(stderr, "huh: %d\n", o);
				helpdie();
		}
	}

	params.filenames = &argv[optind];
	params.numprocs = argc - optind;

	if (params.numprocs <= 0 || params.filesize <= 0)
		helpdie();

	printf("running test with: numprocs=%d filesize=%llu blocksize=%d fallocate=%d sfr=%d fadvise=%d sequential=%d\n",
		   params.numprocs,
		   (unsigned long long) params.filesize, params.blocksize,
		   params.fallocate, params.sync_file_range, params.fadvise, params.sequential);
	fflush(stdout);

	for (int fileno = 0; fileno < params.numprocs; fileno++)
	{
		pid_t	pid = fork();

		if (pid == 0)
		{
			runtest(&params, params.filenames[fileno]);
			exit(0);
		}
		else if (pid < 0)
		{
			perror("fork");
			exit(1);
		}
	}

	while (wait(&status) >= 0)
		;
	sleep(1);

	return 0;
}

void
runtest(const runparams* params, char *filename)
{
	const int bs = params->blocksize;
	const uint64_t filesize = params->filesize;
	const bool sfr = params->sync_file_range;
	const bool fadv = params->fadvise;
	char *junk;

	junk = malloc(bs);
	if (!bs) exit(1);

	memset(junk, 'J', params->blocksize);

	time_t	t0 = time(NULL);
	int fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
	if (fd < 0)
	{
		perror("open");
		exit(1);
	}

	time_t	t1 = time(NULL);

	if (params->fallocate)
	{
		if (posix_fallocate(fd, 0, filesize) != 0)
		{
			perror("posix_fallocate");
			exit(1);
		}
	}


	if (params->sequential)
	{
		if (posix_fadvise(fd, 0, 0, POSIX_FADV_SEQUENTIAL) != 0)
		{
			perror("posix_fallocate");
			exit(1);
		}
	}

	time_t	t2 = time(NULL);
	uint64_t bytes_written = 0;
	uint64_t last_wait_write = 0;
	uint64_t last_start_write = 0;
	uint64_t last_dontneed = 0;

	while (bytes_written + bs < filesize)
	{
		int wc = write(fd, junk, bs);

		if (wc != bs)
		{
			fprintf(stderr, "wc = %d\n", wc);
			perror("write");
			exit(1);
		}
		bytes_written += bs;


		/* wait for last write */
		if (sfr)
		{
			if (last_wait_write + SFR_WAIT_WRITE_DELAY + SFR_WAIT_SIZE < bytes_written)
			{
				if (sync_file_range(fd, last_wait_write, SFR_WAIT_SIZE, SYNC_FILE_RANGE_WAIT_BEFORE) != 0)
				{
					perror("sfr(wait_before)");
					exit(1);
				}
				last_wait_write += SFR_WAIT_SIZE;
			}

			if (last_start_write + SFR_START_WRITE_DELAY + SFR_START_SIZE < bytes_written)
			{

				if (sync_file_range(fd, last_start_write, SFR_START_SIZE, SYNC_FILE_RANGE_WRITE) != 0)
				{
					perror("sfr(write)");
					exit(1);
				}
				last_start_write += SFR_START_SIZE;
			}
		}

		if (fadv)
		{
			if (last_dontneed + FADVISE_DONTNEED_DELAY + FADVISE_DONTNEED_SIZE < bytes_written)
			{
				if (posix_fadvise(fd, last_dontneed, FADVISE_DONTNEED_SIZE, POSIX_FADV_DONTNEED) != 0)
				{
					perror("fadvise(dontneed)");
					exit(1);
				}
				last_dontneed += FADVISE_DONTNEED_SIZE;
			}
		}
	}

	time_t	t3 = time(NULL);
	if (fsync(fd) != 0)
	{
		perror("fsync");
		exit(1);
	}

	time_t	t4 = time(NULL);
	if (close(fd) != 0)
	{
		perror("close");
		exit(1);
	}

	time_t	t5 = time(NULL);
	printf("[%s][%d] open: %lu, fallocate: %lu write: %lu, fsync: %lu, close: %lu, total: %lu\n",
	       filename, getpid(), t1 - t0, t2 - t1, t3 - t2, t4 - t3, t5 - t4, t5 - t0);
}

--u3zpccx366epa2vi--
