Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D455193ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 09:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCZI1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 04:27:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727611AbgCZI1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:27:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02Q82mhs027006
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 04:27:16 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywf2k6rn9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 04:27:16 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Thu, 26 Mar 2020 08:27:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Mar 2020 08:27:11 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02Q8RAcW57868520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 08:27:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA72AA405C;
        Thu, 26 Mar 2020 08:27:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52328A405B;
        Thu, 26 Mar 2020 08:27:09 +0000 (GMT)
Received: from [9.79.188.120] (unknown [9.79.188.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Mar 2020 08:27:09 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_D3DDA360-B6EA-4B33-85FA-E546881B060E"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [powerpc] Intermittent crashes ( link_path_walk) with linux-next 
Date:   Thu, 26 Mar 2020 13:57:08 +0530
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
To:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 20032608-0028-0000-0000-000003EC143F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032608-0029-0000-0000-000024B184AE
Message-Id: <1CB4E533-FD97-4C39-87ED-4857F3AB9097@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_15:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=855 clxscore=1011 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260053
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D3DDA360-B6EA-4B33-85FA-E546881B060E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I am running into intermittent crashes with linux-next on POWER 9 =
PowerVM LPAR
First it was against next-20200324 while running LTP tests. With =
next-20200325
I ran into similar crash (a different stack trace but same failure point =
=E2=80=94 link_path_walk)
while running sosreport command.

BUG: Kernel NULL pointer dereference on read at 0x00000000
Faulting instruction address: 0xc00000000043f278
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in: loop iscsi_target_mod target_core_mod macsec tcp_diag =
udp_diag inet_diag unix_diag af_packet_diag netlink_diag binfmt_misc =
overlay dm_mod nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c =
ip6_tables nft_compat ip_set rfkill nf_tables nfnetlink sunrpc sg =
pseries_rng uio_pdrv_genirq uio sch_fq_codel ip_tables ext4 mbcache jbd2 =
sr_mod sd_mod cdrom t10_pi ibmvscsi scsi_transport_srp ibmveth
CPU: 26 PID: 7771 Comm: avocado Not tainted =
5.6.0-rc7-next-20200324-autotest #1
NIP:  c00000000043f278 LR: c00000000043f330 CTR: 00000000000001fb
REGS: c00000082802f830 TRAP: 0300   Not tainted  =
(5.6.0-rc7-next-20200324-autotest)
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28248442  XER: =
20040000
CFAR: c00000000000dec4 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0=20=

GPR00: c00000000043f330 c00000082802fac0 c00000000155e900 =
0000000000000000=20
GPR04: 0000000000000002 0000000000000000 0000000000000002 =
c0000008b3400000=20
GPR08: 0000000000031419 0000000000000000 0000000000000000 =
ffffffffffff0000=20
GPR12: 0000000000008000 c00000001ec48600 00007fffa08a53f8 =
0000000000000001=20
GPR16: 00007fff9faf9a63 00000100073bec00 00007fff9f2493b0 =
0000000000000000=20
GPR20: 00007fffa1143bf8 00007fffa1103b18 c00000087f547cb3 =
2f2f2f2f2f2f2f2f=20
GPR24: 0000000000000003 0000000000000000 c00000082802fbc8 =
fffffffffffff000=20
GPR28: 0000000000200000 ffffffffffffffff 61c8864680b583eb =
0000000000000000=20
NIP [c00000000043f278] link_path_walk.part.49+0x228/0x400
LR [c00000000043f330] link_path_walk.part.49+0x2e0/0x400
Call Trace:
[c00000082802fac0] [c00000000043f330] link_path_walk.part.49+0x2e0/0x400 =
(unreliable)
[c00000082802fb50] [c00000000043f5a4] path_lookupat.isra.51+0x64/0x1f0
[c00000082802fba0] [c000000000441c00] filename_lookup.part.69+0xa0/0x1b0
[c00000082802fce0] [c00000000042ff38] vfs_statx+0xa8/0x190
[c00000082802fd60] [c0000000004302a0] __do_sys_newstat+0x40/0x90
[c00000082802fe20] [c00000000000b278] system_call+0x5c/0x68
Instruction dump:
3bffffff e93a0058 38800000 7f43d378 7fff07b4 1d5f0030 7d295214 eac90020=20=

4bfffb21 2fa30000 409e00c8 e93a0008 <81290000> 55290256 7f89e000 =
419efecc=20
 ---[ end trace 34abf29ebd56e423 ]=E2=80=94

Relevant snippet from obj dump:

   6dc4:       20 00 c9 ea     ld      r22,32(r9)
                        link =3D walk_component(nd, 0);
    6db4:       78 d3 43 7f     mr      r3,r26
                        name =3D nd->stack[--depth].name;
    6db8:       b4 07 ff 7f     extsw   r31,r31
    6dbc:       30 00 5f 1d     mulli   r10,r31,48
    6dc0:       14 52 29 7d     add     r9,r9,r10
    6dc4:       20 00 c9 ea     ld      r22,32(r9)
                        link =3D walk_component(nd, 0);
    6dc8:       01 00 00 48     bl      6dc8 =
<link_path_walk.part.49+0x218>
                if (unlikely(link)) {
    6dcc:       00 00 a3 2f     cmpdi   cr7,r3,0
    6dd0:       c8 00 9e 40     bne     cr7,6e98 =
<link_path_walk.part.49+0x2e8>
        return dentry->d_flags & DCACHE_ENTRY_TYPE;
    6dd4:       08 00 3a e9     ld      r9,8(r26)
    6dd8:       00 00 29 81     lwz     r9,0(r9)  <<=3D=3D=3D crashes =
here ??
    6ddc:       56 02 29 55     rlwinm  r9,r9,0,9,11
                if (unlikely(!d_can_lookup(nd->path.dentry))) {
    6de0:       00 e0 89 7f     cmpw    cr7,r9,r28

The code in question (link_path_walk() in fs/namei.c ) was recently =
changed by
following commit:

commit 881386f7e46a:=20
  link_path_walk(): sample parent's i_uid and i_mode for the last =
component

Thanks
-Sachin



--Apple-Mail=_D3DDA360-B6EA-4B33-85FA-E546881B060E
Content-Disposition: attachment;
	filename=next-20200325.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="next-20200325.log"
Content-Transfer-Encoding: 7bit

Crash while running sosreport command:

[ 1917.926113] BUG: Kernel NULL pointer dereference on read at 0x00000000
[ 1917.926126] Faulting instruction address: 0xc00000000043f638
[ 1917.926131] Oops: Kernel access of bad area, sig: 11 [#1]
[ 1917.926136] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[ 1917.926147] Dumping ftrace buffer:
[ 1917.926157]    (ftrace buffer empty)
[ 1917.926161] Modules linked in: iscsi_target_mod target_core_mod macsec tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag binfmt_misc overlay dm_mod nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat ip_set rfkill nf_tables nfnetlink sunrpc sg pseries_rng uio_pdrv_genirq uio sch_fq_codel ip_tables ext4 mbcache jbd2 sr_mod cdrom sd_mod t10_pi ibmvscsi scsi_transport_srp ibmveth
[ 1917.926198] CPU: 12 PID: 20734 Comm: busctl Not tainted 5.6.0-rc7-next-20200325-autotest #1
[ 1917.926203] NIP:  c00000000043f638 LR: c00000000043f6f0 CTR: 0000000000000000
[ 1917.926209] REGS: c00000082bc1f720 TRAP: 0300   Not tainted  (5.6.0-rc7-next-20200325-autotest)
[ 1917.926215] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28022422  XER: 20040000
[ 1917.926222] CFAR: c00000000000dec4 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0 
[ 1917.926222] GPR00: c00000000043f6f0 c00000082bc1f9b0 c00000000155e800 0000000000000000 
[ 1917.926222] GPR04: 0000000000000002 0000000000000000 0000000000000002 c0000008b3400000 
[ 1917.926222] GPR08: 000000000000febb 0000000000000000 0000000000000000 ffffffffffff0000 
[ 1917.926222] GPR12: 0000000000002000 c00000001ec5d600 0000000135ed11e0 c0000008879046d0 
[ 1917.926222] GPR16: 7fffffffffffffff fffffffffffffe00 fffffffffffffffc fffffffffffffff5 
[ 1917.926222] GPR20: c00000089fa27200 0000000000000000 c00000008609bf33 2f2f2f2f2f2f2f2f 
[ 1917.926222] GPR24: 0000000000000003 0000000000000000 c00000082bc1fab8 fffffffffffff000 
[ 1917.926222] GPR28: 0000000000200000 ffffffffffffffff 61c8864680b583eb 0000000000000001 
[ 1917.926270] NIP [c00000000043f638] link_path_walk.part.49+0x228/0x400
[ 1917.926275] LR [c00000000043f6f0] link_path_walk.part.49+0x2e0/0x400
[ 1917.926280] Call Trace:
[ 1917.926284] [c00000082bc1f9b0] [c00000000043f6f0] link_path_walk.part.49+0x2e0/0x400 (unreliable)
[ 1917.926291] [c00000082bc1fa40] [c00000000043f964] path_lookupat.isra.51+0x64/0x1f0
[ 1917.926296] [c00000082bc1fa90] [c000000000441fc0] filename_lookup.part.69+0xa0/0x1b0
[ 1917.926303] [c00000082bc1fbd0] [c000000000ae0784] unix_find_other+0x64/0x3f0
[ 1917.926309] [c00000082bc1fc60] [c000000000ae1b78] unix_stream_connect+0x148/0x930
[ 1917.926316] [c00000082bc1fd30] [c000000000933010] __sys_connect+0x140/0x170
[ 1917.926322] [c00000082bc1fe00] [c000000000933068] sys_connect+0x28/0x40
[ 1917.926328] [c00000082bc1fe20] [c00000000000b278] system_call+0x5c/0x68
[ 1917.926332] Instruction dump:
[ 1917.926336] 3bffffff e93a0058 38800000 7f43d378 7fff07b4 1d5f0030 7d295214 eac90020 
[ 1917.926343] 4bfffb21 2fa30000 409e00c8 e93a0008 <81290000> 55290256 7f89e000 419efecc 
[ 1917.926351] ---[ end trace 1b673f0e7295c08b ]---

Objdump o/p
===========


fs/namei.o:     file format elf64-powerpcle


Disassembly of section .text:

0000000000000000 <full_name_hash>:
 * In particular, we must end by hashing a final word containing 0..7
 * payload bytes, to match the way that hash_name() iterates until it
 * finds the delimiter after the name.
 */
unsigned int full_name_hash(const void *salt, const char *name, unsigned int len)
{
       0:	a6 02 08 7c 	mflr    r0
       4:	01 00 00 48 	bl      4 <full_name_hash+0x4>
	unsigned long a, x = 0, y = (unsigned long)salt;

	for (;;) {
		if (!len)
.........
.........

0000000000006bb0 <link_path_walk.part.49>:
static int link_path_walk(const char *name, struct nameidata *nd)
    6bb0:	00 00 4c 3c 	addis   r2,r12,0
    6bb4:	00 00 42 38 	addi    r2,r2,0
    6bb8:	a6 02 08 7c 	mflr    r0
    6bbc:	01 00 00 48 	bl      6bbc <link_path_walk.part.49+0xc>
    6bc0:	b0 ff c1 fa 	std     r22,-80(r1)
    6bc4:	d0 ff 41 fb 	std     r26,-48(r1)
    6bc8:	c0 ff 01 fb 	std     r24,-64(r1)
    6bcc:	78 1b 76 7c 	mr      r22,r3
    6bd0:	71 ff 21 f8 	stdu    r1,-144(r1)
    6bd4:	78 23 9a 7c 	mr      r26,r4
    6bd8:	18 00 41 f8 	std     r2,24(r1)
    6bdc:	78 11 2d e9 	ld      r9,4472(r13)
    6be0:	38 00 21 f9 	std     r9,56(r1)
    6be4:	00 00 20 39 	li      r9,0
	while (*name=='/')
    6be8:	00 00 23 89 	lbz     r9,0(r3)
    6bec:	2f 00 89 2b 	cmplwi  cr7,r9,47
    6bf0:	1c 00 9e 40 	bne     cr7,6c0c <link_path_walk.part.49+0x5c>
    6bf4:	00 00 00 60 	nop
    6bf8:	00 00 00 60 	nop
    6bfc:	00 00 00 60 	nop
    6c00:	01 00 36 8d 	lbzu    r9,1(r22)
    6c04:	2f 00 89 2b 	cmplwi  cr7,r9,47
    6c08:	f8 ff 9e 41 	beq     cr7,6c00 <link_path_walk.part.49+0x50>
	if (!*name)
    6c0c:	00 00 a9 2f 	cmpdi   cr7,r9,0
		return 0;
    6c10:	00 00 00 3b 	li      r24,0
	if (!*name)
    6c14:	3c 00 9e 40 	bne     cr7,6c50 <link_path_walk.part.49+0xa0>
}
    6c18:	38 00 21 e9 	ld      r9,56(r1)
    6c1c:	78 11 4d e9 	ld      r10,4472(r13)
    6c20:	79 52 29 7d 	xor.    r9,r9,r10
    6c24:	00 00 40 39 	li      r10,0
    6c28:	78 c3 03 7f 	mr      r3,r24
    6c2c:	54 03 82 40 	bne     6f80 <link_path_walk.part.49+0x3d0>
    6c30:	90 00 21 38 	addi    r1,r1,144
    6c34:	b0 ff c1 ea 	ld      r22,-80(r1)
    6c38:	c0 ff 01 eb 	ld      r24,-64(r1)
    6c3c:	d0 ff 41 eb 	ld      r26,-48(r1)
    6c40:	20 00 80 4e 	blr
    6c44:	00 00 00 60 	nop
    6c48:	00 00 00 60 	nop
    6c4c:	00 00 00 60 	nop
    6c50:	48 00 e1 fa 	std     r23,72(r1)
    6c54:	80 00 c1 fb 	std     r30,128(r1)
		b = a ^ REPEAT_BYTE('/');
    6c58:	2f 2f e0 3e 	lis     r23,12079
    6c5c:	2f 2f f7 62 	ori     r23,r23,12079
    6c60:	a6 02 08 7c 	mflr    r0
	y ^= x * GOLDEN_RATIO_64;
    6c64:	c8 61 c0 3f 	lis     r30,25032
    6c68:	46 86 de 63 	ori     r30,r30,34374
    6c6c:	58 00 21 fb 	std     r25,88(r1)
    6c70:	68 00 61 fb 	std     r27,104(r1)
	unsigned long a = 0, b, x = 0, y = (unsigned long)salt;
    6c74:	00 00 20 3b 	li      r25,0
    6c78:	70 00 81 fb 	std     r28,112(r1)
    6c7c:	78 00 a1 fb 	std     r29,120(r1)
    6c80:	88 00 e1 fb 	std     r31,136(r1)
	x ^= a & zero_bytemask(mask);
    6c84:	ff ff a0 3b 	li      r29,-1
	int depth = 0; // depth <= nd->depth
    6c88:	00 00 e0 3b 	li      r31,0
		if (unlikely(!d_can_lookup(nd->path.dentry))) {
    6c8c:	20 00 80 3f 	lis     r28,32
			if (IS_ERR(link))
    6c90:	00 f0 60 3b 	li      r27,-4096
		b = a ^ REPEAT_BYTE('/');
    6c94:	c6 07 f7 7a 	rldicr  r23,r23,32,31
	y ^= x * GOLDEN_RATIO_64;
    6c98:	c6 07 de 7b 	rldicr  r30,r30,32,31
		b = a ^ REPEAT_BYTE('/');
    6c9c:	2f 2f f7 66 	oris    r23,r23,12079
    6ca0:	a0 00 01 f8 	std     r0,160(r1)
	y ^= x * GOLDEN_RATIO_64;
    6ca4:	b5 80 de 67 	oris    r30,r30,32949
		b = a ^ REPEAT_BYTE('/');
    6ca8:	2f 2f f7 62 	ori     r23,r23,12079
	y ^= x * GOLDEN_RATIO_64;
    6cac:	eb 83 de 63 	ori     r30,r30,33771
	if (nd->flags & LOOKUP_RCU) {
    6cb0:	38 00 3a 81 	lwz     r9,56(r26)
    6cb4:	30 00 7a e8 	ld      r3,48(r26)
    6cb8:	40 00 29 71 	andi.   r9,r9,64
    6cbc:	08 02 82 41 	beq     6ec4 <link_path_walk.part.49+0x314>
		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
    6cc0:	81 00 80 38 	li      r4,129
    6cc4:	01 00 00 48 	bl      6cc4 <link_path_walk.part.49+0x114>
		if (err != -ECHILD)
    6cc8:	f6 ff 83 2f 	cmpwi   cr7,r3,-10
		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
    6ccc:	78 1b 78 7c 	mr      r24,r3
		if (err != -ECHILD)
    6cd0:	e0 01 9e 41 	beq     cr7,6eb0 <link_path_walk.part.49+0x300>
		if (err)
    6cd4:	00 00 b8 2f 	cmpdi   cr7,r24,0
    6cd8:	30 01 9e 40 	bne     cr7,6e08 <link_path_walk.part.49+0x258>
		hash_len = hash_name(nd->path.dentry, name);
    6cdc:	08 00 7a e8 	ld      r3,8(r26)
	len = 0;
    6ce0:	00 00 a0 38 	li      r5,0
	unsigned long a = 0, b, x = 0, y = (unsigned long)salt;
    6ce4:	00 00 c0 38 	li      r6,0
    6ce8:	78 1b 67 7c 	mr      r7,r3
	goto inside;
    6cec:	24 00 00 48 	b       6d10 <link_path_walk.part.49+0x160>
		HASH_MIX(x, y, a);
    6cf0:	78 4a c9 7c 	xor     r9,r6,r9
		len += sizeof(unsigned long);
    6cf4:	08 00 a5 38 	addi    r5,r5,8
		HASH_MIX(x, y, a);
    6cf8:	78 3a 26 7d 	xor     r6,r9,r7
    6cfc:	00 60 29 79 	rotldi  r9,r9,12
    6d00:	02 68 c7 78 	rotldi  r7,r6,45
    6d04:	14 4a c6 7c 	add     r6,r6,r9
    6d08:	24 1f e9 78 	rldicr  r9,r7,3,60
    6d0c:	14 3a e9 7c 	add     r7,r9,r7
		a = load_unaligned_zeropad(name+len);
    6d10:	14 2a 56 7d 	add     r10,r22,r5
	asm(
    6d14:	00 00 2a e9 	ld      r9,0(r10)
		b = a ^ REPEAT_BYTE('/');
    6d18:	78 ba 2a 7d 	xor     r10,r9,r23
	asm("cmpb %0,%1,%2" : "=r" (ret) : "r" (a), "r" (zero));
    6d1c:	f8 cb 28 7d 	cmpb    r8,r9,r25
    6d20:	f8 cb 4a 7d 	cmpb    r10,r10,r25
	} while (!(has_zero(a, &adata, &constants) | has_zero(b, &bdata, &constants)));
    6d24:	79 53 0a 7d 	or.     r10,r8,r10
    6d28:	c8 ff 82 41 	beq     6cf0 <link_path_walk.part.49+0x140>
	asm("addi	%1,%2,-1\n\t"
    6d2c:	ff ff 0a 39 	addi    r8,r10,-1
    6d30:	78 50 08 7d 	andc    r8,r8,r10
    6d34:	f4 03 0a 7d 	popcntd r10,r8
	x ^= a & zero_bytemask(mask);
    6d38:	36 50 ab 7f 	sld     r11,r29,r10
	return mask >> 3;
    6d3c:	c2 e8 48 79 	rldicl  r8,r10,61,3
		if (name[0] == '.') switch (hashlen_len(hash_len)) {
    6d40:	00 00 96 88 	lbz     r4,0(r22)
	x ^= a & zero_bytemask(mask);
    6d44:	78 58 2a 7d 	andc    r10,r9,r11
	return hashlen_create(fold_hash(x, y), len + find_zero(mask));
    6d48:	14 2a 08 7d 	add     r8,r8,r5
	x ^= a & zero_bytemask(mask);
    6d4c:	78 32 49 7d 	xor     r9,r10,r6
		if (name[0] == '.') switch (hashlen_len(hash_len)) {
    6d50:	2e 00 84 2f 	cmpwi   cr7,r4,46
	y ^= x * GOLDEN_RATIO_64;
    6d54:	d2 f1 29 7d 	mulld   r9,r9,r30
    6d58:	78 3a 29 7d 	xor     r9,r9,r7
	y *= GOLDEN_RATIO_64;
    6d5c:	d2 f1 29 7d 	mulld   r9,r9,r30
	return y >> 32;
    6d60:	22 00 29 79 	rldicl  r9,r9,32,32
	return hashlen_create(fold_hash(x, y), len + find_zero(mask));
    6d64:	0e 00 09 79 	rldimi  r9,r8,32,0
		if (name[0] == '.') switch (hashlen_len(hash_len)) {
    6d68:	c8 00 9e 41 	beq     cr7,6e30 <link_path_walk.part.49+0x280>
    6d6c:	38 00 5a 81 	lwz     r10,56(r26)
			nd->flags &= ~LOOKUP_JUMPED;
    6d70:	24 05 4a 55 	rlwinm  r10,r10,0,20,18
    6d74:	38 00 5a 91 	stw     r10,56(r26)
			if (unlikely(parent->d_flags & DCACHE_OP_HASH)) {
    6d78:	00 00 43 81 	lwz     r10,0(r3)
    6d7c:	01 00 4a 71 	andi.   r10,r10,1
    6d80:	70 01 82 40 	bne     6ef0 <link_path_walk.part.49+0x340>
    6d84:	22 00 28 79 	rldicl  r8,r9,32,32
		nd->last.hash_len = hash_len;
    6d88:	10 00 3a f9 	std     r9,16(r26)
		nd->last.name = name;
    6d8c:	18 00 da fa 	std     r22,24(r26)
		nd->last_type = type;
    6d90:	48 00 1a 93 	stw     r24,72(r26)
		if (!*name)
    6d94:	ee 40 36 7d 	lbzux   r9,r22,r8
    6d98:	00 00 89 2f 	cmpwi   cr7,r9,0
    6d9c:	d4 00 9e 40 	bne     cr7,6e70 <link_path_walk.part.49+0x2c0>
			if (!depth) {
    6da0:	00 00 bf 2f 	cmpdi   cr7,r31,0
    6da4:	ac 01 9e 41 	beq     cr7,6f50 <link_path_walk.part.49+0x3a0>
			name = nd->stack[--depth].name;
    6da8:	ff ff ff 3b 	addi    r31,r31,-1
    6dac:	58 00 3a e9 	ld      r9,88(r26)
			link = walk_component(nd, 0);
    6db0:	00 00 80 38 	li      r4,0
    6db4:	78 d3 43 7f 	mr      r3,r26
			name = nd->stack[--depth].name;
    6db8:	b4 07 ff 7f 	extsw   r31,r31
    6dbc:	30 00 5f 1d 	mulli   r10,r31,48
    6dc0:	14 52 29 7d 	add     r9,r9,r10
    6dc4:	20 00 c9 ea 	ld      r22,32(r9)
			link = walk_component(nd, 0);
    6dc8:	01 00 00 48 	bl      6dc8 <link_path_walk.part.49+0x218>
		if (unlikely(link)) {
    6dcc:	00 00 a3 2f 	cmpdi   cr7,r3,0
    6dd0:	c8 00 9e 40 	bne     cr7,6e98 <link_path_walk.part.49+0x2e8>
	return dentry->d_flags & DCACHE_ENTRY_TYPE;
    6dd4:	08 00 3a e9 	ld      r9,8(r26)
    6dd8:	00 00 29 81 	lwz     r9,0(r9)
    6ddc:	56 02 29 55 	rlwinm  r9,r9,0,9,11
		if (unlikely(!d_can_lookup(nd->path.dentry))) {
    6de0:	00 e0 89 7f 	cmpw    cr7,r9,r28
    6de4:	cc fe 9e 41 	beq     cr7,6cb0 <link_path_walk.part.49+0x100>
			if (nd->flags & LOOKUP_RCU) {
    6de8:	38 00 3a 81 	lwz     r9,56(r26)
    6dec:	40 00 29 71 	andi.   r9,r9,64
    6df0:	38 01 82 41 	beq     6f28 <link_path_walk.part.49+0x378>
				if (unlazy_walk(nd))
    6df4:	78 d3 43 7f 	mr      r3,r26
    6df8:	01 00 00 48 	bl      6df8 <link_path_walk.part.49+0x248>
    6dfc:	00 00 a3 2f 	cmpdi   cr7,r3,0
    6e00:	28 01 9e 41 	beq     cr7,6f28 <link_path_walk.part.49+0x378>
					return -ECHILD;
    6e04:	f6 ff 00 3b 	li      r24,-10
    6e08:	a0 00 01 e8 	ld      r0,160(r1)
    6e0c:	48 00 e1 ea 	ld      r23,72(r1)
    6e10:	58 00 21 eb 	ld      r25,88(r1)
    6e14:	68 00 61 eb 	ld      r27,104(r1)
    6e18:	70 00 81 eb 	ld      r28,112(r1)
    6e1c:	78 00 a1 eb 	ld      r29,120(r1)
    6e20:	80 00 c1 eb 	ld      r30,128(r1)
    6e24:	88 00 e1 eb 	ld      r31,136(r1)
    6e28:	a6 03 08 7c 	mtlr    r0
    6e2c:	ec fd ff 4b 	b       6c18 <link_path_walk.part.49+0x68>
		if (name[0] == '.') switch (hashlen_len(hash_len)) {
    6e30:	22 00 28 79 	rldicl  r8,r9,32,32
    6e34:	20 00 0a 79 	clrldi  r10,r8,32
    6e38:	01 00 8a 2b 	cmplwi  cr7,r10,1
    6e3c:	a4 00 9e 41 	beq     cr7,6ee0 <link_path_walk.part.49+0x330>
    6e40:	02 00 8a 2b 	cmplwi  cr7,r10,2
    6e44:	28 ff 9e 40 	bne     cr7,6d6c <link_path_walk.part.49+0x1bc>
				if (name[1] == '.') {
    6e48:	01 00 f6 88 	lbz     r7,1(r22)
    6e4c:	38 00 5a 81 	lwz     r10,56(r26)
    6e50:	2e 00 87 2f 	cmpwi   cr7,r7,46
    6e54:	1c ff 9e 40 	bne     cr7,6d70 <link_path_walk.part.49+0x1c0>
					nd->flags |= LOOKUP_JUMPED;
    6e58:	00 10 4a 61 	ori     r10,r10,4096
					type = LAST_DOTDOT;
    6e5c:	03 00 00 3b 	li      r24,3
					nd->flags |= LOOKUP_JUMPED;
    6e60:	38 00 5a 91 	stw     r10,56(r26)
		if (likely(type == LAST_NORM)) {
    6e64:	24 ff ff 4b 	b       6d88 <link_path_walk.part.49+0x1d8>
    6e68:	00 00 00 60 	nop
    6e6c:	00 00 00 60 	nop
		} while (unlikely(*name == '/'));
    6e70:	01 00 36 8d 	lbzu    r9,1(r22)
    6e74:	2f 00 89 2b 	cmplwi  cr7,r9,47
    6e78:	f8 ff 9e 41 	beq     cr7,6e70 <link_path_walk.part.49+0x2c0>
		if (unlikely(!*name)) {
    6e7c:	00 00 a9 2f 	cmpdi   cr7,r9,0
    6e80:	20 ff 9e 41 	beq     cr7,6da0 <link_path_walk.part.49+0x1f0>
			link = walk_component(nd, WALK_MORE);
    6e84:	02 00 80 38 	li      r4,2
    6e88:	78 d3 43 7f 	mr      r3,r26
    6e8c:	01 00 00 48 	bl      6e8c <link_path_walk.part.49+0x2dc>
		if (unlikely(link)) {
    6e90:	00 00 a3 2f 	cmpdi   cr7,r3,0
    6e94:	40 ff 9e 41 	beq     cr7,6dd4 <link_path_walk.part.49+0x224>
			if (IS_ERR(link))
    6e98:	40 d8 a3 7f 	cmpld   cr7,r3,r27
    6e9c:	94 00 9d 40 	ble     cr7,6f30 <link_path_walk.part.49+0x380>
				return PTR_ERR(link);
    6ea0:	b4 07 78 7c 	extsw   r24,r3
    6ea4:	64 ff ff 4b 	b       6e08 <link_path_walk.part.49+0x258>
    6ea8:	00 00 00 60 	nop
    6eac:	00 00 00 60 	nop
		if (unlazy_walk(nd))
    6eb0:	78 d3 43 7f 	mr      r3,r26
    6eb4:	01 00 00 48 	bl      6eb4 <link_path_walk.part.49+0x304>
    6eb8:	00 00 a3 2f 	cmpdi   cr7,r3,0
    6ebc:	48 ff 9e 40 	bne     cr7,6e04 <link_path_walk.part.49+0x254>
    6ec0:	30 00 7a e8 	ld      r3,48(r26)
	return inode_permission(nd->inode, MAY_EXEC);
    6ec4:	01 00 80 38 	li      r4,1
    6ec8:	01 00 00 48 	bl      6ec8 <link_path_walk.part.49+0x318>
    6ecc:	78 1b 78 7c 	mr      r24,r3
    6ed0:	04 fe ff 4b 	b       6cd4 <link_path_walk.part.49+0x124>
    6ed4:	00 00 00 60 	nop
    6ed8:	00 00 00 60 	nop
    6edc:	00 00 00 60 	nop
				type = LAST_DOT;
    6ee0:	02 00 00 3b 	li      r24,2
    6ee4:	a4 fe ff 4b 	b       6d88 <link_path_walk.part.49+0x1d8>
    6ee8:	00 00 00 60 	nop
    6eec:	00 00 00 60 	nop
				err = parent->d_op->d_hash(parent, &this);
    6ef0:	60 00 43 e9 	ld      r10,96(r3)
				struct qstr this = { { .hash_len = hash_len }, .name = name };
    6ef4:	28 00 21 f9 	std     r9,40(r1)
    6ef8:	30 00 c1 fa 	std     r22,48(r1)
				err = parent->d_op->d_hash(parent, &this);
    6efc:	28 00 81 38 	addi    r4,r1,40
    6f00:	10 00 2a e9 	ld      r9,16(r10)
    6f04:	78 4b 2c 7d 	mr      r12,r9
    6f08:	a6 03 29 7d 	mtctr   r9
    6f0c:	21 04 80 4e 	bctrl
    6f10:	18 00 41 e8 	ld      r2,24(r1)
				if (err < 0)
    6f14:	00 00 83 2f 	cmpwi   cr7,r3,0
    6f18:	60 00 9c 41 	blt     cr7,6f78 <link_path_walk.part.49+0x3c8>
				hash_len = this.hash_len;
    6f1c:	28 00 21 e9 	ld      r9,40(r1)
				name = this.name;
    6f20:	30 00 c1 ea 	ld      r22,48(r1)
    6f24:	60 fe ff 4b 	b       6d84 <link_path_walk.part.49+0x1d4>
			return -ENOTDIR;
    6f28:	ec ff 00 3b 	li      r24,-20
    6f2c:	dc fe ff 4b 	b       6e08 <link_path_walk.part.49+0x258>
			nd->stack[depth++].name = name;
    6f30:	30 00 5f 1d 	mulli   r10,r31,48
    6f34:	58 00 3a e9 	ld      r9,88(r26)
    6f38:	01 00 ff 3b 	addi    r31,r31,1
    6f3c:	b4 07 ff 7f 	extsw   r31,r31
    6f40:	14 52 29 7d 	add     r9,r9,r10
    6f44:	20 00 c9 fa 	std     r22,32(r9)
    6f48:	78 1b 76 7c 	mr      r22,r3
    6f4c:	64 fd ff 4b 	b       6cb0 <link_path_walk.part.49+0x100>
				nd->dir_uid = nd->inode->i_uid;
    6f50:	30 00 5a e9 	ld      r10,48(r26)
				nd->flags &= ~LOOKUP_PARENT;
    6f54:	38 00 3a 81 	lwz     r9,56(r26)
				return 0;
    6f58:	00 00 00 3b 	li      r24,0
				nd->dir_uid = nd->inode->i_uid;
    6f5c:	04 00 0a 81 	lwz     r8,4(r10)
				nd->flags &= ~LOOKUP_PARENT;
    6f60:	34 07 29 55 	rlwinm  r9,r9,0,28,26
				nd->dir_uid = nd->inode->i_uid;
    6f64:	d8 00 1a 91 	stw     r8,216(r26)
				nd->dir_mode = nd->inode->i_mode;
    6f68:	00 00 4a a1 	lhz     r10,0(r10)
				nd->flags &= ~LOOKUP_PARENT;
    6f6c:	38 00 3a 91 	stw     r9,56(r26)
				nd->dir_mode = nd->inode->i_mode;
    6f70:	dc 00 5a b1 	sth     r10,220(r26)
				return 0;
    6f74:	94 fe ff 4b 	b       6e08 <link_path_walk.part.49+0x258>
				err = parent->d_op->d_hash(parent, &this);
    6f78:	78 1b 78 7c 	mr      r24,r3
    6f7c:	8c fe ff 4b 	b       6e08 <link_path_walk.part.49+0x258>
    6f80:	a6 02 08 7c 	mflr    r0
    6f84:	48 00 e1 fa 	std     r23,72(r1)
    6f88:	58 00 21 fb 	std     r25,88(r1)
    6f8c:	68 00 61 fb 	std     r27,104(r1)
    6f90:	70 00 81 fb 	std     r28,112(r1)
    6f94:	78 00 a1 fb 	std     r29,120(r1)
    6f98:	80 00 c1 fb 	std     r30,128(r1)
    6f9c:	88 00 e1 fb 	std     r31,136(r1)
    6fa0:	a0 00 01 f8 	std     r0,160(r1)
}
    6fa4:	01 00 00 48 	bl      6fa4 <link_path_walk.part.49+0x3f4>
    6fa8:	00 00 00 60 	nop
    6fac:	00 00 00 60 	nop


--Apple-Mail=_D3DDA360-B6EA-4B33-85FA-E546881B060E--

