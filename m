Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937F915CB6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBMTxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:53:52 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:3876 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBMTxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:53:52 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 14:53:50 EST
X-EEMSG-check-017: 58603417|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-EEMSG-Attachment-filename: kvm.cil, userfaultfd.cil, kvm.c, userfaultfd.c
X-EEMSG-Attachment-filesize: 1115, 621, 2234, 870
X-IronPort-AV: E=Sophos;i="5.70,437,1574121600"; 
   d="c'?cil'?scan'208";a="58603417"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Feb 2020 19:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581623195; x=1613159195;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=ALUVptGGMslrhVQNJqMME0pB8k6xyz3v2MmpazMeWm8=;
  b=blwOHwFEIRoBz1pQCdvuuFMFRqgUCJrwa4Z2kljWeRaAAd2pf7VjSZLa
   xW4QLcklFwNOnEky73WtxAodMTmJucwNT0+vgP4oqICSC8FO6DUBitU02
   8FqF/fJdtcIOaK+cH/h+6tlqmq2c6DhwyiL/aGjpVKo4Rt2yKsGbeH624
   O6KKgy9d/G/l/JCK+dNp1CuEqQX+V6Q/wK4iT38HXRS5iE/yeQzxexmTV
   FVVbmMKQyVM12ACTPPBMb0YTrAr0HBIrgoN9s0FuiepMwBCrYZ7AeXL0M
   9Rd01NSEVL5gQc86UhJluWol6x6BqBG57V4UTbdoq5y+dY7t38v4HWKlk
   A==;
X-Attachment-Exists: TRUE
X-IronPort-AV: E=Sophos;i="5.70,437,1574121600"; 
   d="c'?cil'?scan'208";a="33048248"
IronPort-PHdr: =?us-ascii?q?9a23=3ASRMxeRDGx9+11N8fnhiVUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP35p8qwAkXT6L1XgUPTWs2DsrQY0raQ7fCrADZfqb+681k8M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi5oAnLt8QbgoRuJrsvxh?=
 =?us-ascii?q?bLv3BFZ/lYyWR0KF2cmBrx+t2+94N5/SRKvPIh+c9AUaHkcKk9ULdVEjcoPX?=
 =?us-ascii?q?0r6cPyrRXMQheB6XUaUmUNjxpHGBPF4w3gXpfwqST1qOxw0zSHMMLsTLA0XT?=
 =?us-ascii?q?Oi77p3SBLtlSwKOSI1/H3Rh8dtgq1buhahrAFhzYDSbo+eKf5ycrrdcN4eQG?=
 =?us-ascii?q?ZMWNtaWS5cDYOmd4YBEvQPPehYoYf+qVUBoxSxCguwC+70zz9EmmX70Lcm3+?=
 =?us-ascii?q?kvEwzL2hErEdIUsHTTqdX4LLocUfyrw6nQzTXMcfVW0irg5ojNaB8hpfWMUq?=
 =?us-ascii?q?xwcMHMzkQvDB7Kjk6LpIz5PzKayuQNs2+B4+pmTuKgkXQrqw52ojix38ohjJ?=
 =?us-ascii?q?TCiIENyl3c6Cl0z4k4Kce4RUJme9KoDpRduz+AO4drRM4pXntmtzwgyrIcvJ?=
 =?us-ascii?q?62ZC0KyJM6yBHBc/GHaI2I4g77VOaWPDd4mGppeLKhiBa29kit0vH8WdOu0F?=
 =?us-ascii?q?ZLsypFicPAtnEL1xzd7ciHUeVy8Vu71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnmFSjjjNrx/HAPr38DZTANWbDkLj/cr?=
 =?us-ascii?q?Zn8UJcyxQ8zcpZ551KDrENOvXzWlX+tNbAFB82LxS0w/r7CNV6zo4eXWOPAq?=
 =?us-ascii?q?mEMKLdqFOI/fwgLPWRZI8PuTb9N/gk6+frjX8+hFAdYK2p0oUMZXCmEfRpPV?=
 =?us-ascii?q?+ZbWDvgtgfC2cKuBQxTOjwhF2FSz5TaG64X7gg6TEjFIKmEYDDS5ipgLyA2i?=
 =?us-ascii?q?e7A5JXanlIClCXDHjnaZuEVOkIaC+JPM9hnSILVaK7R48iyx6urgn6xKRjLu?=
 =?us-ascii?q?bO/S0Yr53j3sBv5+LPjREy6SB0D8OF3mGOUWF0m3gFRyE53K9hu0xx0FSD3r?=
 =?us-ascii?q?Zig/xeC9NT4+lFUgAgNZ7T1+Z6Ecz9WhrdfteVT1arWsumATArTtI22NIPYl?=
 =?us-ascii?q?hyG9OjjhDdxSaqB74Vl7qWBJ076K7c2GLxJ8lnx3bb16krl0MmTddXNW26mq?=
 =?us-ascii?q?5/8BDeB5bTnEWEk6anbrwc0zTQ9GeH1GaOuUZYUAlqUarbR3wQekzWrdHh7E?=
 =?us-ascii?q?PYU7CuEagnMhdGycOaN6RFcNvpgklBRPfnI9nebGWxm2C/BRaM2LyAdpble2?=
 =?us-ascii?q?IY3C/FEkgLjxgT/WqaNQg5HiqhpWTeDD91GFLgZEPs9uZ+qHelQUMu0w6KaE?=
 =?us-ascii?q?hhhPKJ/UsOiPidTe4D9qwLtT1nqDhuGlu5mdXMBImuvQ1kKZ5AbMs97VEP7m?=
 =?us-ascii?q?fQswhwL9T0NKx5rkIPeARw+UX13lN4DZsWwptil28j0AcncfHQ61hGbT7NmM?=
 =?us-ascii?q?2hNw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AtAwAtpkVe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSAShD6JA4ZfBoE3iXCRSgkBAQEBAQEBAQEDIBQEAQGEQAKCcDgTAhABA?=
 =?us-ascii?q?QEFAQEBAQEFAwEBbIVDgjspgwMBBSMEUhALGCoCAgJVEwgBAYJjPwGCViWuB?=
 =?us-ascii?q?n8zhUqDPIEuEIE4gVOKa3mBB4E4D4JdPoRignmCXgSNTYl4DTl8lm+CRIJPg?=
 =?us-ascii?q?R6CO4Eljn4GHIJIjF6LcS2reSKBWCsIAhgIIQ+DJwlHGA2BGo0PFxWOLCMDj?=
 =?us-ascii?q?Q4sghcBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Feb 2020 19:46:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01DJjbsW102736;
        Thu, 13 Feb 2020 14:45:37 -0500
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, dancol@google.com,
        nnk@google.com
References: <20200213194157.5877-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <513f6230-1fb3-dbb5-5f75-53cd02b91b28@tycho.nsa.gov>
Date:   Thu, 13 Feb 2020 14:47:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213194157.5877-1-sds@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------936176FE2E25230FE1E6A035"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------936176FE2E25230FE1E6A035
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/20 2:41 PM, Stephen Smalley wrote:
> An example of a sample program and policy will follow in a follow-up
> to this patch to demonstrate the effect on userfaultfd and kvm.

Attached are example test programs and policies to demonstrate the 
change in behavior before and after this RFC patch for userfaultfd and 
kvm.  The test policies can be edited to selectively allow specific 
permissions for testing various scenarios, but with the defaults in 
them, one should see the following behavior:

sudo semodule -i kvm.cil userfaultfd.cil
make kvm userfaultfd

Before:

(no labeling/access control applied by SELinux to userfaultfd files or 
to anon inodes created by kvm)

$ ./userfaultfd
api: 170
features: 510
ioctls: 9223372036854775811

read: Resource temporarily unavailable

$ ./kvm
api version: 12

created vm

created vcpu

rax: 0
rbx: 0
rcx: 0
rdx: 1536
rdi: 0
rsi: 0
rsp: 0
rbp: 0
r8: 0
r9: 0
r10: 0
r11: 0
r12: 0
r13: 0
r14: 0
r15: 0
rip: 65520
rflags: 2

created device

checked device attr

After:

(SELinux ioctl whitelisting used to selectively deny access)

./userfaultfd
UFFDIO_API: Permission denied

$ ./kvm
api version: 12

created vm

created vcpu

KVM_GET_REGS: Permission denied

--------------936176FE2E25230FE1E6A035
Content-Type: application/vnd.ms-artgalry;
 name="kvm.cil"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="kvm.cil"

OyBVbmNvbW1lbnQgb25lIG9mIHRoZSBhbGxvd3ggbGluZXMgYmVsb3cgdG8gdGVzdC4KOyBD
dXJyZW50bHkgdGhlIDR0aCBvbmUgaXMgdW5jb21tZW50ZWQ7IGNvbW1lbnQgdGhhdCBvdXQg
aWYgdHJ5aW5nIGFub3RoZXIuCgo7IE5vbmUKOyhhbGxvd3ggdW5jb25maW5lZF90IGt2bV9k
ZXZpY2VfdCAoaW9jdGwgY2hyX2ZpbGUgKCgweDAwKSkpKQoKOyBLVk1fR0VUX0FQSV9WRVJT
SU9OCjsoYWxsb3d4IHVuY29uZmluZWRfdCBrdm1fZGV2aWNlX3QgKGlvY3RsIGNocl9maWxl
ICgoMHhhZTAwKSkpKQoKOyBLVk1fR0VUX0FQSV9WRVJTSU9OCUtWTV9DUkVBVEVfVk0KOyhh
bGxvd3ggdW5jb25maW5lZF90IGt2bV9kZXZpY2VfdCAoaW9jdGwgY2hyX2ZpbGUgKCgweGFl
MDAgMHhhZTAxKSkpKQoKOyBLVk1fR0VUX0FQSV9WRVJTSU9OCUtWTV9DUkVBVEVfVk0JS1ZN
X0NSRUFURV9WQ1BVCihhbGxvd3ggdW5jb25maW5lZF90IGt2bV9kZXZpY2VfdCAoaW9jdGwg
Y2hyX2ZpbGUgKCgweGFlMDAgMHhhZTAxIDB4YWU0MSkpKSkKCjsgS1ZNX0dFVF9BUElfVkVS
U0lPTglLVk1fQ1JFQVRFX1ZNCUtWTV9DUkVBVEVfVkNQVQlLVk1fR0VUX1JFR1MKOyhhbGxv
d3ggdW5jb25maW5lZF90IGt2bV9kZXZpY2VfdCAoaW9jdGwgY2hyX2ZpbGUgKCgweGFlMDAg
MHhhZTAxIDB4YWU0MSAweGFlODEpKSkpCgo7IEtWTV9HRVRfQVBJX1ZFUlNJT04gICAgICAg
IEtWTV9DUkVBVEVfVk0gICAgICAgIEtWTV9DUkVBVEVfVkNQVQo7IEtWTV9HRVRfUkVHUyAg
ICAgICAgICAgICAgIEtWTV9DUkVBVEVfREVWSUNFCjsoYWxsb3d4IHVuY29uZmluZWRfdCBr
dm1fZGV2aWNlX3QgKGlvY3RsIGNocl9maWxlICgoMHhhZTAwIDB4YWUwMSAweGFlNDEgMHhh
ZTgxIDB4YWVlMCkpKSkKCjsgS1ZNX0dFVF9BUElfVkVSU0lPTiAgICAgICAgS1ZNX0NSRUFU
RV9WTSAgICAgICAgS1ZNX0NSRUFURV9WQ1BVCjsgS1ZNX0dFVF9SRUdTICAgICAgICAgICAg
ICAgS1ZNX0NSRUFURV9ERVZJQ0UgICAgS1ZNX0hBU19ERVZJQ0VfQVRUUgo7KGFsbG93eCB1
bmNvbmZpbmVkX3Qga3ZtX2RldmljZV90IChpb2N0bCBjaHJfZmlsZSAoKDB4YWUwMCAweGFl
MDEgMHhhZTQxIDB4YWU4MSAweGFlZTAgMHhhZWUzKSkpKQo=
--------------936176FE2E25230FE1E6A035
Content-Type: application/vnd.ms-artgalry;
 name="userfaultfd.cil"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="userfaultfd.cil"

KHR5cGUgdWZmZF90KQoKOyBMYWJlbCB0aGUgVUZGRCB3aXRoIHVmZmRfdDsgdGhpcyBjYW4g
YmUgc3BlY2lhbGl6ZWQgcGVyIGRvbWFpbgoodHlwZXRyYW5zaXRpb24gdW5jb25maW5lZF90
IHVuY29uZmluZWRfdCBmaWxlICJbdXNlcmZhdWx0ZmRdIiAgIHVmZmRfdCkKCjsgUGVybWl0
IHJlYWQoKSBhbmQgaW9jdGwoKSBvbiB0aGUgVUZGRC4KOyBDb21tZW50IG91dCBpZiB5b3Ug
d2FudCB0byB0ZXN0IHJlYWQgb3IgYmFzaWMgaW9jdGwgZW5mb3JjZW1lbnQuCihhbGxvdyB1
bmNvbmZpbmVkX3QgdWZmZF90IChmaWxlIChyZWFkKSkpCihhbGxvdyB1bmNvbmZpbmVkX3Qg
dWZmZF90IChmaWxlIChpb2N0bCkpKQoKOyBVbmNvbW1lbnQgb25lIG9mIHRoZSBhbGxvd3gg
bGluZXMgYmVsb3cgdG8gdGVzdCBpb2N0bCB3aGl0ZWxpc3RpbmcuCjsgQ3VycmVudGx5IHRo
ZSAxc3Qgb25lIGlzIHVuY29tbWVudGVkOyBjb21tZW50IHRoYXQgb3V0IGlmIHRyeWluZyBh
bm90aGVyLgoKOyBOb25lCihhbGxvd3ggdW5jb25maW5lZF90IHVmZmRfdCAoaW9jdGwgZmls
ZSAoKDB4MDApKSkpCgo7IFVGRkRJT19BUEkKOyhhbGxvd3ggdW5jb25maW5lZF90IHVmZmRf
dCAoaW9jdGwgZmlsZSAoKDB4YWEzZikpKSkK
--------------936176FE2E25230FE1E6A035
Content-Type: text/x-csrc; charset=UTF-8;
 name="kvm.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kvm.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <linux/kvm.h>

void print_regs(const struct kvm_regs *regs)
{
	printf("rax: %llu\n", regs->rax);
	printf("rbx: %llu\n", regs->rbx);
	printf("rcx: %llu\n", regs->rcx);
	printf("rdx: %llu\n", regs->rdx);
	printf("rdi: %llu\n", regs->rdi);
	printf("rsi: %llu\n", regs->rsi);
	printf("rsp: %llu\n", regs->rsp);
	printf("rbp: %llu\n", regs->rbp);
	printf("r8: %llu\n", regs->r8);
	printf("r9: %llu\n", regs->r9);
	printf("r10: %llu\n", regs->r10);
	printf("r11: %llu\n", regs->r11);
	printf("r12: %llu\n", regs->r12);
	printf("r13: %llu\n", regs->r13);
	printf("r14: %llu\n", regs->r14);
	printf("r15: %llu\n", regs->r15);
	printf("rip: %llu\n", regs->rip);
	printf("rflags: %llu\n", regs->rflags);

	printf("\n");
}

void print_device_attr(const struct kvm_device_attr *dev_attr)
{
	printf("flags: %u\n", dev_attr->flags);
	printf("group: %u\n", dev_attr->group);
	printf("attr: %llu\n", dev_attr->attr);
	printf("addr: %llu\n", dev_attr->addr);

	printf("\n");
}

int main(void)
{
	int fd = open("/dev/kvm", O_RDWR);
	if (fd < 0) {
		perror("/dev/kvm");
		return -1;
	}

	int ret = ioctl(fd, KVM_GET_API_VERSION, 0);
	if (ret < 0) {
		perror("KVM_GET_API_VERSION");
		return -1;
	}

	printf("api version: %d\n\n", ret);

	int vmfd = ioctl(fd, KVM_CREATE_VM, 0);
	if (vmfd < 0) {
		perror("KVM_CREATE_VM");
		return -1;
	}

	printf("created vm\n\n");

	int vcpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
	if (vcpufd < 0) {
		perror("KVM_CREATE_VCPU");
		return -1;
	}

	printf("created vcpu\n\n");

	struct kvm_regs regs;
	if (ioctl(vcpufd, KVM_GET_REGS, &regs) < 0) {
		perror("KVM_GET_REGS");
		return -1;
	}

	print_regs(&regs);

	struct kvm_create_device dev = {0};
	dev.type = KVM_DEV_TYPE_VFIO;

	if (ioctl(vmfd, KVM_CREATE_DEVICE, &dev) < 0) {
		perror("KVM_CREATE_DEVICE");
		return -1;
	}

	printf("created device\n\n");

	struct kvm_device_attr dev_attr = {0};
	dev_attr.group = KVM_DEV_VFIO_GROUP;
	dev_attr.attr = KVM_DEV_VFIO_GROUP_ADD;
	if (ioctl(dev.fd, KVM_HAS_DEVICE_ATTR, &dev_attr) < 0) {
		perror("KVM_HAS_DEVICE_ATTR");
		return -1;
	}

	printf("checked device attr\n\n");

	return 0;
}

--------------936176FE2E25230FE1E6A035
Content-Type: text/x-csrc; charset=UTF-8;
 name="userfaultfd.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="userfaultfd.c"

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>

#include <linux/userfaultfd.h>

void print_api(const struct uffdio_api *api)
{
	printf("api: %llu\n", api->api);
	printf("features: %llu\n", api->features);
	printf("ioctls: %llu\n", api->ioctls);

	printf("\n");
}

int main(void)
{
	long uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
	if (uffd < 0) {
		perror("syscall(userfaultfd)");
		return -1;
	}

	struct uffdio_api api = {0};
	api.api = UFFD_API;
	if (ioctl(uffd, UFFDIO_API, &api) < 0) {
		perror("UFFDIO_API");
		return -1;
	}

	print_api(&api);

	struct uffd_msg msg = {0};
	ssize_t count = read(uffd, &msg, sizeof(msg));
	if (count < 0) {
		perror("read");
		return -1;
	} else if (count == 0) {
		printf("read EOF\n\n");
	}

	printf("read uffd\n\n");

	return 0;
}

--------------936176FE2E25230FE1E6A035--
