Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3A21498C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGEBmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 21:42:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:58855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgGEBmJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 21:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593913319;
        bh=bIc6mW5ZgCCz7N/Od5++hsIKrtMyHwUvUOlhu+gVczM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J1jxb27hy0A+8uueQ3/Av1p4h7c/jARdKKtJWkXajc9Y8QKZ5Kl8TN6UADg1PJvz/
         kOAzt0rUvMSmJPU5m7zYoJQwhcGsVLGC8Kvlub6GCBNzaRYYWRjx1BLH1nEtWX+xXy
         WzZk51s90hUKjJFLsshmrf9bUqzu/nMWV5W3JYPg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([88.152.145.75]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1kJ9HO2I0j-00RtTu; Sun, 05
 Jul 2020 03:41:59 +0200
Subject: Re: [PATCH 3/3] selftests: add readfile(2) selftests
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-4-gregkh@linuxfoundation.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <fdaa31b7-b045-e38b-680a-01f0389e6acc@gmx.de>
Date:   Sun, 5 Jul 2020 03:41:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200704140250.423345-4-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LJfiw8Apmf1gsQtzS7+PgdvvDz9M26VTdjQ7xQeQxd8XweDkg1Z
 3nYSPjRwJCqTXlea5mYYKODwd+AV/6JoYfR075ja3QGisho4m7TQ722Cn1CVIoj8Q4wqPBX
 q4wdd7lSHTt8XdTtOIM3/MBjc7DYFim1BnZ/k+wpbGp4HqTLczVwS/e9kScaDLjWNT/7ju/
 /PcBvMfzCyV07SbTWhcCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fu7rGgmZgIg=:8UPnzAFXLZ4K/f5JoP+XoN
 rwSLUeIuPP4duqQ4eNNE1lUFRl+y82U9ZfHKvJ3iI7A4Lqu2nb6D2aKvNOUKd8RqoAu1XqJwF
 nfN5tf9RDtzctQhkogiUdePp5RCVPgoLXD1v28OICsN/hwbSKgCHd8z89QqFtEcFUNHGsY0nm
 DrwZm61NAmBBaaje1RguwiIw44j/HLhyP5YtM92i2F5viMwGyCh77e19MTcMCBKb9SvubLdgH
 dXOjdvzm0ZshQCiZm7DEib7T4ZReXTrSgBKuknUJxghnocDYbqJie2HrrbYCBwodNHq51N8i3
 WfhiYXKDkH00721jGqkXj9hOaF3J5CUJkyQzd6keGyu/CiwUZUDq9G4FEggik3sP+33MdVYWl
 6UdSPMPQguscTd3H1wSWaLU+K99iRdpDe2BVlTc4cHoNeVTfQJaypazX6xwzouyj3JgYHihMk
 rqDiD7kBYlGmB4Lc06I9/huVnmnREyh1ZV3sKs62x2wu5ACBRkgJDARpfmzdQdI/iEEemoS5e
 iMAofWeXe/X0zcd8ETM9W0ZzZ1zZWNGbQ4idoDiIgNGCTWC4eeuH0UGA3rGjL670PaVfSkelC
 rY/3c1et9yi+EI78EFKudy2jmHOu2Wz+mrvtEPTeNjt+NYrSJZeI8I6uMOTFZerlTop9r01qH
 VyOYyJbKi9/BJT2K7k3G6Ruojt9EnXYH6xP/OoJM7BtM+0I31LArTg0GpZZ7H9YmSbGNG5YbE
 Ivva+pRkmD/sXTAgCKCm4VyhNNMXMTcDY2OizAIi0dKkkOEE6350PID/8iU2FEJurbdKLnLyG
 XnJIFEws/esO2yF+z6b4asuF2a5psBfqSzBJrRVwCTgLaETHE2KVronLUQALiUWj5waumO0At
 /5/e+eAIhWSIJxcyom3ciJVDFpYiOLbEByubeFD9E1VxlpuTnNx5ln5cYIwRzW6v/sW9chA6b
 5eXaA90/PUa6QjrkkREiAqPm6vOFqcwPjGb/ASG6u5A+98tFhsb92Vzp5qy5grT92mfja4HI+
 j0s06Q/Yu3wm3j6BWSIinUUe+mSGNpdK2DI1xSYwDUTbP8Bl2nbf6eLN++rnfgmwGjkRZXcC1
 7tjReagriBBW6I4lRJkfxeMG/7wlZBMFk1nOCgJOouT5hE31Iocimo+C5tp1CbQOgW6DCTPUd
 VR985SpjpQYvvoJaC6h18chtNOzmkhLZPH2aY/5/5NcVWlqsA8vjbISJuM9oARCnz1VXjgAlP
 h/3BUjCDSzqpdWIfiV9uFqLWBoPtMK0UItdhVfw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/20 4:02 PM, Greg Kroah-Hartman wrote:
> Test the functionality of readfile(2) in various ways.

Hello Greg,

I expect readfile() to generate fanotify events FAN_OPEN_PERM, FAN_OPEN,
FAN_ACCESS_PERM, FAN_ACCESS, FAN_CLOSE_NOWRITE in this sequence.

Looking at patch 1/3 you took care of notifications. Would this deserve
testing here?

Best regards

Heinrich

>
> Also provide a simple speed test program to benchmark using readfile()
> instead of using open()/read()/close().
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/readfile/.gitignore   |   3 +
>  tools/testing/selftests/readfile/Makefile     |   7 +
>  tools/testing/selftests/readfile/readfile.c   | 285 +++++++++++++++++
>  .../selftests/readfile/readfile_speed.c       | 301 ++++++++++++++++++
>  5 files changed, 597 insertions(+)
>  create mode 100644 tools/testing/selftests/readfile/.gitignore
>  create mode 100644 tools/testing/selftests/readfile/Makefile
>  create mode 100644 tools/testing/selftests/readfile/readfile.c
>  create mode 100644 tools/testing/selftests/readfile/readfile_speed.c
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/=
Makefile
> index 1195bd85af38..82359233b945 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -46,6 +46,7 @@ TARGETS +=3D ptrace
>  TARGETS +=3D openat2
>  TARGETS +=3D rseq
>  TARGETS +=3D rtc
> +TARGETS +=3D readfile
>  TARGETS +=3D seccomp
>  TARGETS +=3D sigaltstack
>  TARGETS +=3D size
> diff --git a/tools/testing/selftests/readfile/.gitignore b/tools/testing=
/selftests/readfile/.gitignore
> new file mode 100644
> index 000000000000..f0e758d437e4
> --- /dev/null
> +++ b/tools/testing/selftests/readfile/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +readfile
> +readfile_speed
> diff --git a/tools/testing/selftests/readfile/Makefile b/tools/testing/s=
elftests/readfile/Makefile
> new file mode 100644
> index 000000000000..1bf1bdec40f8
> --- /dev/null
> +++ b/tools/testing/selftests/readfile/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS +=3D -g -I../../../../usr/include/
> +CFLAGS +=3D -O2 -Wl,-no-as-needed -Wall
> +
> +TEST_GEN_PROGS :=3D readfile readfile_speed
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/readfile/readfile.c b/tools/testing=
/selftests/readfile/readfile.c
> new file mode 100644
> index 000000000000..f0736c6dfa69
> --- /dev/null
> +++ b/tools/testing/selftests/readfile/readfile.c
> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> + * Copyright (c) 2020 The Linux Foundation
> + *
> + * Test the readfile() syscall in various ways.
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <string.h>
> +#include <syscall.h>
> +
> +#include "../kselftest.h"
> +
> +//#ifndef __NR_readfile
> +//#define __NR_readfile	-1
> +//#endif
> +
> +#define __NR_readfile	440
> +
> +#define TEST_FILE1	"/sys/devices/system/cpu/vulnerabilities/meltdown"
> +#define TEST_FILE2	"/sys/devices/system/cpu/vulnerabilities/spectre_v1"
> +#define TEST_FILE4	"/sys/kernel/debug/usb/devices"
> +
> +static int sys_readfile(int fd, const char *filename, unsigned char *bu=
ffer,
> +			size_t bufsize, int flags)
> +{
> +	return syscall(__NR_readfile, fd, filename, buffer, bufsize, flags);
> +}
> +
> +/*
> + * Test that readfile() is even in the running kernel or not.
> + */
> +static void test_readfile_supported(void)
> +{
> +	const char *proc_map =3D "/proc/self/maps";
> +	unsigned char buffer[10];
> +	int retval;
> +
> +	if (__NR_readfile < 0)
> +		ksft_exit_skip("readfile() syscall is not defined for the kernel this=
 test was built against\n");
> +
> +	/*
> +	 * Do a simple test to see if the syscall really is present in the
> +	 * running kernel
> +	 */
> +	retval =3D sys_readfile(0, proc_map, &buffer[0], sizeof(buffer), 0);
> +	if (retval =3D=3D -1)
> +		ksft_exit_skip("readfile() syscall not present on running kernel\n");
> +
> +	ksft_test_result_pass("readfile() syscall present\n");
> +}
> +
> +/*
> + * Open all files in a specific sysfs directory and read from them
> + *
> + * This tests the "openat" type functionality of opening all files rela=
tive to a
> + * directory.  We don't care at the moment about the contents.
> + */
> +static void test_sysfs_files(void)
> +{
> +	static unsigned char buffer[8000];
> +	const char *sysfs_dir =3D "/sys/devices/system/cpu/vulnerabilities/";
> +	struct dirent *dirent;
> +	DIR *vuln_sysfs_dir;
> +	int sysfs_fd;
> +	int retval;
> +
> +	sysfs_fd =3D open(sysfs_dir, O_PATH | O_DIRECTORY);
> +	if (sysfs_fd =3D=3D -1) {
> +		ksft_test_result_skip("unable to open %s directory\n",
> +				      sysfs_dir);
> +		return;
> +	}
> +
> +	vuln_sysfs_dir =3D opendir(sysfs_dir);
> +	if (!vuln_sysfs_dir) {
> +		ksft_test_result_skip("%s unable to be opened, skipping test\n");
> +		return;
> +	}
> +
> +	ksft_print_msg("readfile: testing relative path functionality by readi=
ng files in %s\n",
> +		       sysfs_dir);
> +	/* open all sysfs file in this directory and read the whole thing */
> +	while ((dirent =3D readdir(vuln_sysfs_dir))) {
> +		/* ignore . and .. */
> +		if (strcmp(dirent->d_name, ".") =3D=3D 0 ||
> +		    strcmp(dirent->d_name, "..") =3D=3D 0)
> +			continue;
> +
> +		retval =3D sys_readfile(sysfs_fd, dirent->d_name, &buffer[0],
> +				      sizeof(buffer), 0);
> +
> +		if (retval <=3D 0) {
> +			ksft_test_result_fail("readfile(%s) failed with %d\n",
> +					      dirent->d_name, retval);
> +			goto exit;
> +		}
> +
> +		/* cut off trailing \n character */
> +		buffer[retval - 1] =3D 0x00;
> +		ksft_print_msg("    '%s' contains \"%s\"\n", dirent->d_name,
> +			       buffer);
> +	}
> +
> +	ksft_test_result_pass("readfile() relative path functionality passed\n=
");
> +
> +exit:
> +	closedir(vuln_sysfs_dir);
> +	close(sysfs_fd);
> +}
> +
> +/* Temporary directory variables */
> +static int root_fd;		/* test root directory file handle */
> +static char tmpdir[PATH_MAX];
> +
> +static void setup_tmpdir(void)
> +{
> +	char *tmpdir_root;
> +
> +	tmpdir_root =3D getenv("TMPDIR");
> +	if (!tmpdir_root)
> +		tmpdir_root =3D "/tmp";
> +
> +	snprintf(tmpdir, PATH_MAX, "%s/readfile.XXXXXX", tmpdir_root);
> +	if (!mkdtemp(tmpdir)) {
> +		ksft_test_result_fail("mkdtemp(%s) failed\n", tmpdir);
> +		ksft_exit_fail();
> +	}
> +
> +	root_fd =3D open(tmpdir, O_PATH | O_DIRECTORY);
> +	if (root_fd =3D=3D -1) {
> +		ksft_exit_fail_msg("%s unable to be opened, error =3D %d\n",
> +				   tmpdir, root_fd);
> +		ksft_exit_fail();
> +	}
> +
> +	ksft_print_msg("%s created to use for testing\n", tmpdir);
> +}
> +
> +static void teardown_tmpdir(void)
> +{
> +	int retval;
> +
> +	close(root_fd);
> +
> +	retval =3D rmdir(tmpdir);
> +	if (retval) {
> +		ksft_exit_fail_msg("%s removed with return value %d\n",
> +				   tmpdir, retval);
> +		ksft_exit_fail();
> +	}
> +	ksft_print_msg("%s cleaned up and removed\n", tmpdir);
> +
> +}
> +
> +static void test_filesize(size_t size)
> +{
> +	char filename[PATH_MAX];
> +	unsigned char *write_data;
> +	unsigned char *read_data;
> +	int fd;
> +	int retval;
> +	size_t i;
> +
> +	snprintf(filename, PATH_MAX, "size-%ld", size);
> +
> +	read_data =3D malloc(size);
> +	write_data =3D malloc(size);
> +	if (!read_data || !write_data)
> +		ksft_exit_fail_msg("Unable to allocate %ld bytes\n", size);
> +
> +	fd =3D openat(root_fd, filename, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
> +	if (fd < 0)
> +		ksft_exit_fail_msg("Unable to create file %s\n", filename);
> +
> +	ksft_print_msg("%s created\n", filename);
> +
> +	for (i =3D 0; i < size; ++i)
> +		write_data[i] =3D (unsigned char)(0xff & i);
> +
> +	write(fd, write_data, size);
> +	close(fd);
> +
> +	retval =3D sys_readfile(root_fd, filename, read_data, size, 0);
> +
> +	if (retval !=3D size) {
> +		ksft_test_result_fail("Read %d bytes but wanted to read %ld bytes.\n"=
,
> +				      retval, size);
> +		goto exit;
> +	}
> +
> +	if (memcmp(read_data, write_data, size) !=3D 0) {
> +		ksft_test_result_fail("Read data of buffer size %d did not match writ=
ten data\n",
> +				      size);
> +		goto exit;
> +	}
> +
> +	ksft_test_result_pass("readfile() of size %ld succeeded.\n", size);
> +
> +exit:
> +	unlinkat(root_fd, filename, 0);
> +	free(write_data);
> +	free(read_data);
> +}
> +
> +
> +/*
> + * Create a bunch of differently sized files, and verify we read the co=
rrect
> + * amount of data from them.
> + */
> +static void test_filesizes(void)
> +{
> +	setup_tmpdir();
> +
> +	test_filesize(0x10);
> +	test_filesize(0x100);
> +	test_filesize(0x1000);
> +	test_filesize(0x10000);
> +	test_filesize(0x100000);
> +	test_filesize(0x1000000);
> +
> +	teardown_tmpdir();
> +
> +}
> +
> +static void readfile(const char *filename)
> +{
> +//	int root_fd;
> +	unsigned char buffer[16000];
> +	int retval;
> +
> +	memset(buffer, 0x00, sizeof(buffer));
> +
> +//	root_fd =3D open("/", O_DIRECTORY);
> +//	if (root_fd =3D=3D -1)
> +//		ksft_exit_fail_msg("error with root_fd\n");
> +
> +	retval =3D sys_readfile(root_fd, filename, &buffer[0], sizeof(buffer),=
 0);
> +
> +//	close(root_fd);
> +
> +	if (retval <=3D 0)
> +		ksft_test_result_fail("readfile() test of filename=3D%s failed with r=
etval %d\n",
> +				      filename, retval);
> +	else
> +		ksft_test_result_pass("readfile() test of filename=3D%s succeeded wit=
h retval=3D%d\n",
> +				      filename, retval);
> +//	buffer=3D'%s'\n",
> +//	       filename, retval, &buffer[0]);
> +
> +}
> +
> +
> +int main(int argc, char *argv[])
> +{
> +	ksft_print_header();
> +	ksft_set_plan(10);
> +
> +	test_readfile_supported();	// 1 test
> +
> +	test_sysfs_files();		// 1 test
> +
> +	test_filesizes();		// 6 tests
> +
> +	setup_tmpdir();
> +
> +	readfile(TEST_FILE1);
> +	readfile(TEST_FILE2);
> +//	readfile(TEST_FILE4);
> +
> +	teardown_tmpdir();
> +
> +	if (ksft_get_fail_cnt())
> +		return ksft_exit_fail();
> +
> +	return ksft_exit_pass();
> +}
> +
> diff --git a/tools/testing/selftests/readfile/readfile_speed.c b/tools/t=
esting/selftests/readfile/readfile_speed.c
> new file mode 100644
> index 000000000000..11ca79163131
> --- /dev/null
> +++ b/tools/testing/selftests/readfile/readfile_speed.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> + * Copyright (c) 2020 The Linux Foundation
> + *
> + * Tiny test program to try to benchmark the speed of the readfile sysc=
all vs.
> + * the open/read/close sequence it can replace.
> + */
> +#define _GNU_SOURCE
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <syscall.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +/* Default test file if no one wants to pick something else */
> +#define DEFAULT_TEST_FILE	"/sys/devices/system/cpu/vulnerabilities/melt=
down"
> +
> +#define DEFAULT_TEST_LOOPS	1000
> +
> +#define DEFAULT_TEST_TYPE	"both"
> +
> +/* Max number of bytes that will be read from the file */
> +#define TEST_BUFFER_SIZE	10000
> +static unsigned char test_buffer[TEST_BUFFER_SIZE];
> +
> +enum test_type {
> +	TEST_READFILE,
> +	TEST_OPENREADCLOSE,
> +	TEST_BOTH,
> +};
> +
> +/* Find the readfile syscall number */
> +//#ifndef __NR_readfile
> +//#define __NR_readfile	-1
> +//#endif
> +#define __NR_readfile	440
> +
> +static int sys_readfile(int fd, const char *filename, unsigned char *bu=
ffer,
> +			size_t bufsize, int flags)
> +{
> +	return syscall(__NR_readfile, fd, filename, buffer, bufsize, flags);
> +}
> +
> +/* Test that readfile() is even in the running kernel or not.  */
> +static void test_readfile_supported(void)
> +{
> +	const char *proc_map =3D "/proc/self/maps";
> +	unsigned char buffer[10];
> +	int retval;
> +
> +	if (__NR_readfile < 0) {
> +		fprintf(stderr,
> +			"readfile() syscall is not defined for the kernel this test was buil=
t against.\n");
> +		exit(1);
> +	}
> +
> +	/*
> +	 * Do a simple test to see if the syscall really is present in the
> +	 * running kernel
> +	 */
> +	retval =3D sys_readfile(0, proc_map, &buffer[0], sizeof(buffer), 0);
> +	if (retval =3D=3D -1) {
> +		fprintf(stderr,
> +			"readfile() syscall not present on running kernel.\n");
> +		exit(1);
> +	}
> +}
> +
> +static inline long long get_time_ns(void)
> +{
> +        struct timespec t;
> +
> +        clock_gettime(CLOCK_MONOTONIC, &t);
> +
> +        return (long long)t.tv_sec * 1000000000 + t.tv_nsec;
> +}
> +
> +/* taken from all-io.h from util-linux repo */
> +static inline ssize_t read_all(int fd, unsigned char *buf, size_t count=
)
> +{
> +	ssize_t ret;
> +	ssize_t c =3D 0;
> +	int tries =3D 0;
> +
> +	while (count > 0) {
> +		ret =3D read(fd, buf, count);
> +		if (ret <=3D 0) {
> +			if (ret < 0 && (errno =3D=3D EAGAIN || errno =3D=3D EINTR) &&
> +			    (tries++ < 5)) {
> +				usleep(250000);
> +				continue;
> +			}
> +			return c ? c : -1;
> +		}
> +		tries =3D 0;
> +		count -=3D ret;
> +		buf +=3D ret;
> +		c +=3D ret;
> +	}
> +	return c;
> +}
> +
> +static int openreadclose(const char *filename, unsigned char *buffer,
> +			 size_t bufsize)
> +{
> +	size_t count;
> +	int fd;
> +
> +	fd =3D openat(0, filename, O_RDONLY);
> +	if (fd < 0) {
> +		printf("error opening %s\n", filename);
> +		return fd;
> +	}
> +
> +	count =3D read_all(fd, buffer, bufsize);
> +	if (count < 0) {
> +		printf("Error %ld reading from %s\n", count, filename);
> +	}
> +
> +	close(fd);
> +	return count;
> +}
> +
> +static int run_test(enum test_type test_type, const char *filename)
> +{
> +	switch (test_type) {
> +	case TEST_READFILE:
> +		return sys_readfile(0, filename, &test_buffer[0],
> +				    TEST_BUFFER_SIZE, O_RDONLY);
> +
> +	case TEST_OPENREADCLOSE:
> +		return openreadclose(filename, &test_buffer[0],
> +				     TEST_BUFFER_SIZE);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const char * const test_names[] =3D {
> +	[TEST_READFILE]		=3D "readfile",
> +	[TEST_OPENREADCLOSE]	=3D "open/read/close",
> +};
> +
> +static int run_test_loop(int loops, enum test_type test_type,
> +			 const char *filename)
> +{
> +	long long time_start;
> +	long long time_end;
> +	long long time_elapsed;
> +	int retval =3D 0;
> +	int i;
> +
> +	fprintf(stdout,
> +		"Running %s test on file %s for %d loops...\n",
> +		test_names[test_type], filename, loops);
> +
> +	/* Fill the cache with one run of the read first */
> +	retval =3D run_test(test_type, filename);
> +	if (retval < 0) {
> +		fprintf(stderr,
> +			"test %s was unable to run with error %d\n",
> +			test_names[test_type], retval);
> +		return retval;
> +	}
> +
> +	time_start =3D get_time_ns();
> +
> +	for (i =3D 0; i < loops; ++i) {
> +		retval =3D run_test(test_type, filename);
> +
> +		if (retval < 0) {
> +			fprintf(stderr,
> +				"test failed on loop %d with error %d\n",
> +				i, retval);
> +			break;
> +		}
> +	}
> +	time_end =3D get_time_ns();
> +
> +	time_elapsed =3D time_end - time_start;
> +
> +	fprintf(stdout, "Took %lld ns\n", time_elapsed);
> +
> +	return retval;
> +}
> +
> +static int do_read_file_test(int loops, enum test_type test_type,
> +			     const char *filename)
> +{
> +	int retval;
> +
> +	if (test_type =3D=3D TEST_BOTH) {
> +		retval =3D do_read_file_test(loops, TEST_READFILE, filename);
> +		retval =3D do_read_file_test(loops, TEST_OPENREADCLOSE, filename);
> +		return retval;
> +	}
> +	return run_test_loop(loops, test_type, filename);
> +}
> +
> +static int check_file_present(const char *filename)
> +{
> +	struct stat sb;
> +	int retval;
> +
> +	retval =3D stat(filename, &sb);
> +	if (retval =3D=3D -1) {
> +		fprintf(stderr,
> +			"filename %s is not present\n", filename);
> +		return retval;
> +	}
> +
> +	if ((sb.st_mode & S_IFMT) !=3D S_IFREG) {
> +		fprintf(stderr,
> +			"filename %s must be a real file, not anything else.\n",
> +			filename);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage: %s [options]\n"
> +		" -l loops     Number of loops to run the test for.\n"
> +		"              default is %d\n"
> +		" -t testtype  Test type to run.\n"
> +		"              types are: readfile, openreadclose, both\n"
> +		"              default is %s\n"
> +		" -f filename  Filename to read from, full path, not relative.\n"
> +		"              default is %s\n",
> +		progname,
> +		DEFAULT_TEST_LOOPS, DEFAULT_TEST_TYPE, DEFAULT_TEST_FILE);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *progname;
> +	char *testtype =3D DEFAULT_TEST_TYPE;
> +	char *filename =3D DEFAULT_TEST_FILE;
> +	int loops =3D DEFAULT_TEST_LOOPS;
> +	enum test_type test_type;
> +	int retval;
> +	char c;
> +
> +	progname =3D strrchr(argv[0], '/');
> +	progname =3D progname ? 1+progname : argv[0];
> +
> +	while (EOF !=3D (c =3D getopt(argc, argv, "t:l:f:h"))) {
> +		switch (c) {
> +		case 'l':
> +			loops =3D atoi(optarg);
> +			break;
> +
> +		case 't':
> +			testtype =3D optarg;
> +			break;
> +
> +		case 'f':
> +			filename =3D optarg;
> +			break;
> +
> +		case 'h':
> +			usage(progname);
> +			return 0;
> +
> +		default:
> +			usage(progname);
> +			return -1;
> +		}
> +	}
> +
> +	if (strcmp(testtype, "readfile") =3D=3D 0)
> +		test_type =3D TEST_READFILE;
> +	else if (strcmp(testtype, "openreadclose") =3D=3D 0)
> +		test_type =3D TEST_OPENREADCLOSE;
> +	else if (strcmp(testtype, "both") =3D=3D 0)
> +		test_type =3D TEST_BOTH;
> +	else {
> +		usage(progname);
> +		return -1;
> +	}
> +
> +	test_readfile_supported();
> +
> +	retval =3D check_file_present(filename);
> +	if (retval)
> +		return retval;
> +
> +	return do_read_file_test(loops, test_type, filename);
> +}
>

