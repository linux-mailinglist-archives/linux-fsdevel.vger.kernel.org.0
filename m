Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F7A221C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 07:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfERFuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 01:50:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:23785 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfERFuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 01:50:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 22:49:58 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2019 22:49:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hRsED-0005px-KE; Sat, 18 May 2019 13:49:53 +0800
Date:   Sat, 18 May 2019 13:49:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     kbuild-all@01.org, viro@zeniv.linux.org.uk,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com,
        niveditas98@gmail.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
Message-ID: <201905181320.40kqTTSD%lkp@intel.com>
References: <20190517165519.11507-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517165519.11507-3-roberto.sassu@huawei.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Roberto,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1 next-20190517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Roberto-Sassu/initramfs-set-extended-attributes/20190518-055846
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   init/initramfs.c:24:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *buf @@    got f] <asn:1> *buf @@
   init/initramfs.c:24:45: sparse:    expected char const [noderef] <asn:1> *buf
   init/initramfs.c:24:45: sparse:    got char const *p
   init/initramfs.c:115:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got n:1> *filename @@
   init/initramfs.c:115:36: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:115:36: sparse:    got char *filename
   init/initramfs.c:303:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *name @@    got n:1> *name @@
   init/initramfs.c:303:24: sparse:    expected char const [noderef] <asn:1> *name
   init/initramfs.c:303:24: sparse:    got char *path
   init/initramfs.c:305:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/initramfs.c:305:36: sparse:    expected char const [noderef] <asn:1> *pathname
   init/initramfs.c:305:36: sparse:    got char *path
   init/initramfs.c:307:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got n:1> *pathname @@
   init/initramfs.c:307:37: sparse:    expected char const [noderef] <asn:1> *pathname
   init/initramfs.c:307:37: sparse:    got char *path
   init/initramfs.c:317:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *oldname @@    got n:1> *oldname @@
   init/initramfs.c:317:43: sparse:    expected char const [noderef] <asn:1> *oldname
   init/initramfs.c:317:43: sparse:    got char *old
   init/initramfs.c:317:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *newname @@    got char char const [noderef] <asn:1> *newname @@
   init/initramfs.c:317:48: sparse:    expected char const [noderef] <asn:1> *newname
   init/initramfs.c:317:48: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:404:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *name @@    got n:1> *name @@
   init/initramfs.c:404:25: sparse:    expected char const [noderef] <asn:1> *name
   init/initramfs.c:404:25: sparse:    got char *
>> init/initramfs.c:490:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *name @@    got char char const [noderef] <asn:1> *name @@
   init/initramfs.c:490:32: sparse:    expected char const [noderef] <asn:1> *name
   init/initramfs.c:490:32: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:500:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got char char const [noderef] <asn:1> *filename @@
   init/initramfs.c:500:41: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:500:41: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:512:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *pathname @@    got char char const [noderef] <asn:1> *pathname @@
   init/initramfs.c:512:28: sparse:    expected char const [noderef] <asn:1> *pathname
   init/initramfs.c:512:28: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:513:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got char char const [noderef] <asn:1> *filename @@
   init/initramfs.c:513:28: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:513:28: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:514:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got char char const [noderef] <asn:1> *filename @@
   init/initramfs.c:514:28: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:514:28: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:519:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got char char const [noderef] <asn:1> *filename @@
   init/initramfs.c:519:36: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:519:36: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:520:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got char char const [noderef] <asn:1> *filename @@
   init/initramfs.c:520:36: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:520:36: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:521:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got char char const [noderef] <asn:1> *filename @@
   init/initramfs.c:521:36: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:521:36: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:552:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *oldname @@    got n:1> *oldname @@
   init/initramfs.c:552:32: sparse:    expected char const [noderef] <asn:1> *oldname
   init/initramfs.c:552:32: sparse:    got char *
   init/initramfs.c:552:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *newname @@    got char char const [noderef] <asn:1> *newname @@
   init/initramfs.c:552:53: sparse:    expected char const [noderef] <asn:1> *newname
   init/initramfs.c:552:53: sparse:    got char *static [toplevel] [assigned] collected
   init/initramfs.c:553:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected char const [noderef] <asn:1> *filename @@    got char char const [noderef] <asn:1> *filename @@
   init/initramfs.c:553:21: sparse:    expected char const [noderef] <asn:1> *filename
   init/initramfs.c:553:21: sparse:    got char *static [toplevel] [assigned] collected

vim +490 init/initramfs.c

   310	
   311	static int __init maybe_link(void)
   312	{
   313		if (nlink >= 2) {
   314			char *old = find_link(major, minor, ino, mode, collected);
   315			if (old) {
   316				clean_path(collected, 0);
 > 317				return (ksys_link(old, collected) < 0) ? -1 : 1;
   318			}
   319		}
   320		return 0;
   321	}
   322	
   323	struct xattr_hdr {
   324		char c_size[8]; /* total size including c_size field */
   325		char c_data[];  /* <name>\0<value> */
   326	};
   327	
   328	static int __init __maybe_unused do_setxattrs(char *pathname)
   329	{
   330		char *buf = xattr_buf;
   331		char *bufend = buf + xattr_len;
   332		struct xattr_hdr *hdr;
   333		char str[sizeof(hdr->c_size) + 1];
   334		struct path path;
   335	
   336		if (!xattr_len)
   337			return 0;
   338	
   339		str[sizeof(hdr->c_size)] = 0;
   340	
   341		while (buf < bufend) {
   342			char *xattr_name, *xattr_value;
   343			unsigned long xattr_entry_size;
   344			unsigned long xattr_name_size, xattr_value_size;
   345			int ret;
   346	
   347			if (buf + sizeof(hdr->c_size) > bufend) {
   348				error("malformed xattrs");
   349				break;
   350			}
   351	
   352			hdr = (struct xattr_hdr *)buf;
   353			memcpy(str, hdr->c_size, sizeof(hdr->c_size));
   354			ret = kstrtoul(str, 16, &xattr_entry_size);
   355			buf += xattr_entry_size;
   356			if (ret || buf > bufend || !xattr_entry_size) {
   357				error("malformed xattrs");
   358				break;
   359			}
   360	
   361			xattr_name = hdr->c_data;
   362			xattr_name_size = strnlen(xattr_name,
   363						xattr_entry_size - sizeof(hdr->c_size));
   364			if (xattr_name_size == xattr_entry_size - sizeof(hdr->c_size)) {
   365				error("malformed xattrs");
   366				break;
   367			}
   368	
   369			xattr_value = xattr_name + xattr_name_size + 1;
   370			xattr_value_size = buf - xattr_value;
   371	
   372			ret = kern_path(pathname, 0, &path);
   373			if (!ret) {
   374				ret = vfs_setxattr(path.dentry, xattr_name, xattr_value,
   375						   xattr_value_size, 0);
   376	
   377				path_put(&path);
   378			}
   379	
   380			pr_debug("%s: %s size: %lu val: %s (ret: %d)\n", pathname,
   381				 xattr_name, xattr_value_size, xattr_value, ret);
   382		}
   383	
   384		return 0;
   385	}
   386	
   387	struct path_hdr {
   388		char p_size[10]; /* total size including p_size field */
   389		char p_data[];   /* <path>\0<xattrs> */
   390	};
   391	
   392	static int __init do_readxattrs(void)
   393	{
   394		struct path_hdr hdr;
   395		char *path = NULL;
   396		char str[sizeof(hdr.p_size) + 1];
   397		unsigned long file_entry_size;
   398		size_t size, path_size, total_size;
   399		struct kstat st;
   400		struct file *file;
   401		loff_t pos;
   402		int ret;
   403	
   404		ret = vfs_lstat(XATTR_LIST_FILENAME, &st);
   405		if (ret < 0)
   406			return ret;
   407	
   408		total_size = st.size;
   409	
   410		file = filp_open(XATTR_LIST_FILENAME, O_RDONLY, 0);
   411		if (IS_ERR(file))
   412			return PTR_ERR(file);
   413	
   414		pos = file->f_pos;
   415	
   416		while (total_size) {
   417			size = kernel_read(file, (char *)&hdr, sizeof(hdr), &pos);
   418			if (size != sizeof(hdr)) {
   419				ret = -EIO;
   420				goto out;
   421			}
   422	
   423			total_size -= size;
   424	
   425			str[sizeof(hdr.p_size)] = 0;
   426			memcpy(str, hdr.p_size, sizeof(hdr.p_size));
   427			ret = kstrtoul(str, 16, &file_entry_size);
   428			if (ret < 0)
   429				goto out;
   430	
   431			file_entry_size -= sizeof(sizeof(hdr.p_size));
   432			if (file_entry_size > total_size) {
   433				ret = -EINVAL;
   434				goto out;
   435			}
   436	
   437			path = vmalloc(file_entry_size);
   438			if (!path) {
   439				ret = -ENOMEM;
   440				goto out;
   441			}
   442	
   443			size = kernel_read(file, path, file_entry_size, &pos);
   444			if (size != file_entry_size) {
   445				ret = -EIO;
   446				goto out_free;
   447			}
   448	
   449			total_size -= size;
   450	
   451			path_size = strnlen(path, file_entry_size);
   452			if (path_size == file_entry_size) {
   453				ret = -EINVAL;
   454				goto out_free;
   455			}
   456	
   457			xattr_buf = path + path_size + 1;
   458			xattr_len = file_entry_size - path_size - 1;
   459	
   460			ret = do_setxattrs(path);
   461			vfree(path);
   462			path = NULL;
   463	
   464			if (ret < 0)
   465				break;
   466		}
   467	out_free:
   468		vfree(path);
   469	out:
   470		fput(file);
   471	
   472		if (ret < 0)
   473			error("Unable to parse xattrs");
   474	
   475		return ret;
   476	}
   477	
   478	static __initdata int wfd;
   479	
   480	static int __init do_name(void)
   481	{
   482		state = SkipIt;
   483		next_state = Reset;
   484		if (strcmp(collected, "TRAILER!!!") == 0) {
   485			free_hash();
   486			return 0;
   487		} else if (strcmp(collected, XATTR_LIST_FILENAME) == 0) {
   488			struct kstat st;
   489	
 > 490			if (!vfs_lstat(collected, &st))
   491				do_readxattrs();
   492		}
   493		clean_path(collected, mode);
   494		if (S_ISREG(mode)) {
   495			int ml = maybe_link();
   496			if (ml >= 0) {
   497				int openflags = O_WRONLY|O_CREAT;
   498				if (ml != 1)
   499					openflags |= O_TRUNC;
   500				wfd = ksys_open(collected, openflags, mode);
   501	
   502				if (wfd >= 0) {
   503					ksys_fchown(wfd, uid, gid);
   504					ksys_fchmod(wfd, mode);
   505					if (body_len)
   506						ksys_ftruncate(wfd, body_len);
   507					vcollected = kstrdup(collected, GFP_KERNEL);
   508					state = CopyFile;
   509				}
   510			}
   511		} else if (S_ISDIR(mode)) {
   512			ksys_mkdir(collected, mode);
   513			ksys_chown(collected, uid, gid);
   514			ksys_chmod(collected, mode);
   515			dir_add(collected, mtime);
   516		} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
   517			   S_ISFIFO(mode) || S_ISSOCK(mode)) {
   518			if (maybe_link() == 0) {
   519				ksys_mknod(collected, mode, rdev);
   520				ksys_chown(collected, uid, gid);
   521				ksys_chmod(collected, mode);
   522				do_utime(collected, mtime);
   523			}
   524		}
   525		return 0;
   526	}
   527	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
